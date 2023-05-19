Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34E7096FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjESMCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjESMCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:02:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF6C18F;
        Fri, 19 May 2023 05:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 852B565714;
        Fri, 19 May 2023 12:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441D7C433EF;
        Fri, 19 May 2023 12:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684497748;
        bh=aUS8W90dTjFtHRr5ELiJEI3YIx95XhkEyqi9qJUIPf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsLYf9h3VKVvflYL7lhrEMVuy931qaFIru5NBh429e/ULynt2sWUkpSwykjNaN0zD
         BJPSmzqsYRs6eLCb35SSGOHx1gVzVkPdmvtaIqlB/S/0LLAo/6eAYIMMKfljMlGUHr
         dOBZ3ahBiDeL0P8YYnrY2K8gpGAGl/so9UZsbHzbywsaLwSboq4mMEFwAQzVxizGsn
         6dgDKIEnNpRaw5951EzV/3U9N3MetZdwCPNUhUGuDiZ8bZDVIVFbwxwzRP2SGDrO+g
         q6mkYPqYYUIBctcbwcMIHDJJUHs2oGy78pT8AuUx8MjZYBABAIv92mDOHHh2wJb8sw
         IsQE4FbELGTEw==
Date:   Fri, 19 May 2023 14:02:23 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A pass-through support for NFSv4 style ACL
Message-ID: <20230519-verfrachten-gurte-a648ebd0a2fa@brauner>
References: <20230516124655.82283-1-jlayton@kernel.org>
 <20230516-notorisch-geblickt-6b591fbd77c1@brauner>
 <TYXPR01MB18549D3A5B0BE777D7F6B284D9799@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <cc4317d9cb8f10aa0b3750bdb6db8b4e77ff26f8.camel@kernel.org>
 <20230517-herstellen-zitat-21eeccd36558@brauner>
 <20230517123914.GA4578@mit.edu>
 <20230519-allzu-aufmerksam-c3098b5ecf0d@brauner>
 <TYXPR01MB185439828CC7CEC40425065BD97C9@TYXPR01MB1854.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYXPR01MB185439828CC7CEC40425065BD97C9@TYXPR01MB1854.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 11:38:30AM +0000, Ondrej Valousek wrote:
> > 
> > I'll note most of this complexity is only necessary if you want to 
> > have local file access to the file system work with similar semantics 
> > as what would get exported via NFSv4.  If you didn't, you could just 
> > store the Windows-style ACL in an xattr and just let it be set via the 
> > remote file system, and return it when the remote file system queries 
> > it.  The problem comes when you want to have "RichACLs" actually 
> > influence the local Linux permissions check.
> 
> > Yeah, I'm already scared enough.
> 
> Well I do not think it's that difficult. As I said, just take a look how OmniOS does things, very nice - you can set up a VM with it in just a half an hour and you get a system with ZFS and native NFSv4 working.
> True it's not Richacl, but just NFSv4 style acl - even better.
> 
> As for the implementation, lot of code could be presumably taken from Samba which is already doing Windows style-ACL to NFSv4 translation.
> 
> To me interesting bit was that the original path from Andreas was not accepted largely because it would add another piece of mess to the already messy code in the kernel, I did not know that.
> I hoped that  now that Christian cleaned the code recently, it would perhaps allow us to reconsider things, but maybe I am too naive here 😊

Noo one is going to stop you from writing the code and posting it on the
list. But I think none of us here will be very eager to implement it. If
it can be done cleanly without performance regressions or unwiedly
complications in the generic lookup and permission checking code and
both posix acls and these nfs4 style acls can be abstracted away nicely
in a single file, and have well-defined semantics and there's a clear
use-case that isn't just someone's hobby project then it might be
considered. But it might also mean you've spent significant effort just
to hear a no in the end.
