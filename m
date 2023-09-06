Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1602C793FF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 17:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbjIFPHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242358AbjIFPHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:07:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972310F7;
        Wed,  6 Sep 2023 08:07:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D479CC433C8;
        Wed,  6 Sep 2023 15:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694012842;
        bh=2LWbQi4z4sPhz6DRBdN+Cobmt6CtRxaaeG21yCpyf5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTN8vats4+bU42h64M7QJsgEOWXuvqzAYYluj9bdKsyhTfhHPYOz/En9wN18e/zQc
         UwPSYDkmOmjpNcO71I23cRJAkp6XnthVHBth+eECiDKQKae4cqPB8uz7PxeapbiXGm
         oFu66C+HWHUiARfYPRWu2qzi73oJQx0EZ6pkECYKxXVprDOQkVVLoJwUoBjjeDVGOW
         jSadUqo2neAzW6jtZKERy55xzpOUTf2CSL8VdhrJXHhp7jZGZenCxwzGXOLFJNTefM
         y74GDU9CSPg8LoTPH2xbn7TN/AwC44jBQgkfxVBPGrW2jkiV1SeEpNjkhjMOXVAFDL
         FIoZFqmnzNsKA==
Date:   Wed, 6 Sep 2023 17:07:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     David Sterba <dsterba@suse.cz>, Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/2] Use exclusive lock for file_remove_privs
Message-ID: <20230906-gehege-zahnrad-a8a7737d8618@brauner>
References: <20230831112431.2998368-1-bschubert@ddn.com>
 <20230905180259.GG14420@twin.jikos.cz>
 <20230906-teeservice-erbfolge-a23bfa3180eb@brauner>
 <30b8c2b6-1ce2-cef1-0d65-dc12787c9294@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30b8c2b6-1ce2-cef1-0d65-dc12787c9294@fastmail.fm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 04:51:20PM +0200, Bernd Schubert wrote:
> 
> 
> On 9/6/23 16:43, Christian Brauner wrote:
> > On Tue, Sep 05, 2023 at 08:02:59PM +0200, David Sterba wrote:
> > > On Thu, Aug 31, 2023 at 01:24:29PM +0200, Bernd Schubert wrote:
> > > > While adding shared direct IO write locks to fuse Miklos noticed
> > > > that file_remove_privs() needs an exclusive lock. I then
> > > > noticed that btrfs actually has the same issue as I had in my patch,
> > > > it was calling into that function with a shared lock.
> > > > This series adds a new exported function file_needs_remove_privs(),
> > > > which used by the follow up btrfs patch and will be used by the
> > > > DIO code path in fuse as well. If that function returns any mask
> > > > the shared lock needs to be dropped and replaced by the exclusive
> > > > variant.
> > > > 
> > > > Note: Compilation tested only.
> > > 
> > > The fix makes sense, there should be no noticeable performance impact,
> > > basically the same check is done in the newly exported helper for the
> > > IS_NOSEC bit.  I can give it a test locally for the default case, I'm
> > > not sure if we have specific tests for the security layers in fstests.
> > > 
> > > Regarding merge, I can take the two patches via btrfs tree or can wait
> > > until the export is present in Linus' tree in case FUSE needs it
> > > independently.
> > 
> > Both fuse and btrfs need it afaict. We can grab it and provide a tag
> > post -rc1? Whatever works best.
> 
> fuse will need it for my direct IO patches - hopefully in 6.7.
> For btrfs it is a bug fix, should go in asap?
> 
> Christoph has some objections for to use the new exported helper
> (file_needs_remove_privs). Maybe I better send a version for btrfs
> that only uses S_NOSEC? For fuse we cannot use it, unfortunately.

Sure.
