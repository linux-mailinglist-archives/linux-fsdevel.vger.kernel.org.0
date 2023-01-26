Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0F867CAF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 13:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbjAZMbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 07:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjAZMbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:31:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337024900B;
        Thu, 26 Jan 2023 04:31:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8F256171A;
        Thu, 26 Jan 2023 12:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414D4C433EF;
        Thu, 26 Jan 2023 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674736259;
        bh=vREGzkq+bPL/Z76zAsHlWevTeL+rDpASMNvBRnphyuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbNtYzGTxfAtX1HH/O/f6F0nhnSDnGlU8hJFQJglyD1N96KI9bOmqPyYG0FYCqF7m
         /EIS1knBwnhVBQkFwEoaer+G0eVSd5woxF49Nh5jSTnnPpHCXpa8xt094Np9yLx2ED
         hYCBhQFOgpmSuqi43vPYpc7mhB6TuJGwLwEPJQKHl6ee0N46F9lVJNvCqQdwYmx2hz
         gQarmSO+7ilgIoQY4a5k9DHCcNEDlw6Ni+yIl6tOgye8JV3/oMJWplqXJafRw5NEHQ
         nUwPy2p0K+5/6CUdiEfTGQtyfglXEAGTC/YSCRbQSZugSL1yQCL6fkv9mx/P96K+7R
         eRaJcQCp5Lp0w==
Date:   Thu, 26 Jan 2023 13:30:53 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Val Cowan <vcowan@redhat.com>
Subject: Re: [RFC PATCH v1 0/6] proc: Add allowlist for procfs files
Message-ID: <Y9JyfQwAB/M5QmuH@example.org>
References: <cover.1674660533.git.legion@kernel.org>
 <20230125153628.43c12cbe05423fef7d44f0dd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125153628.43c12cbe05423fef7d44f0dd@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 03:36:28PM -0800, Andrew Morton wrote:
> On Wed, 25 Jan 2023 16:28:47 +0100 Alexey Gladkov <legion@kernel.org> wrote:
> 
> > The patch expands subset= option. If the proc is mounted with the
> > subset=allowlist option, the /proc/allowlist file will appear. This file
> > contains the filenames and directories that are allowed for this
> > mountpoint. By default, /proc/allowlist contains only its own name.
> > Changing the allowlist is possible as long as it is present in the
> > allowlist itself.
> > 
> > This allowlist is applied in lookup/readdir so files that will create
> > modules after mounting will not be visible.
> > 
> > Compared to the previous patches [1][2], I switched to a special virtual
> > file from listing filenames in the mount options.
> > 
> 
> Changlog doesn't explain why you think Linux needs this feature.  The
> [2/6] changelog hints that containers might be involved.  IOW, please
> fully describe the requirement and use-case(s).

Ok. I will.

Basically, as Christian described, the motivation is to give
containerization programs (docker, podman, etc.) a way to control the
content in procfs.

Now container tools use a list of dangerous files that they hide with
overmount. But procfs is not a static filesystem and using a bad list to
hide dangerous files can't be the solution.

I believe that a container should define a list of files that it considers
useful within the container, and not try to hide what it considers
unwanted.

> Also, please describe why /proc/allowlist is made available via a mount
> option, rather than being permanently present.

Like subset=pid, this file is needed to change the visibility of files in
the procfs mountpoint.

> And why add to subset=, instead of a separate mount option.
> 
> Does /proc/allowlist work in subdirectories?  Like, permit presence of
> /proc/sys/vm/compact_memory?

Yes. But /proc/allowlist is limited in size to 128K.

> I think the whole thing is misnamed, really.  "allowlist" implies
> access permissions.  Some of the test here uses "visibility" and other
> places use "presence", which are better.  "presentlist" and
> /proc/presentlist might be better.  But why not simply /proc/contents?

I don't hold on to the name allowlist at all :) present list is perfect
for me. The /proc/contents is confusing to me. 

> Please run these patches through checkpatch and consider the result.

Ok. I will.

-- 
Rgrds, legion

