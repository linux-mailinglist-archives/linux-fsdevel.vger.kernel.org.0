Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7706C5EC767
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiI0PQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiI0PQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:16:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFE4178A3;
        Tue, 27 Sep 2022 08:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB780B81C4A;
        Tue, 27 Sep 2022 15:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56328C433C1;
        Tue, 27 Sep 2022 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664291802;
        bh=rcAZBUp0PwJTCX6bTBbA3Tisqexrr45MWrA/dEc4zQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlHcKKjXExGDsoklcQ4MKzdsk3cGtrk58WOsdiU6X9WElsr6hEWw+wi3h+foumk3b
         I1sp6PELR92YpK0TBLBCJQBErme2MvuJYImkMyvO86s+acgi2xJfQ6VPfkME/kjegN
         dm7RVxv77/zy9QDST5BQa5WFzjfl71lPiDGDbJxsHQ5jJp+KD0BmnmzlLrzAtl5pFD
         6TtkQ/7hQxsfL6PWzj2BSltiVgCpGE1Xmgx1yWHQ4Zixpbh3GlFaBRyJbgU+Y4TPMO
         HSEhNOrT9R4al9XQOt06hirChXFo/Z8+7dNi62I6Juq/9g28aG4UyY894eUYAolmam
         KbrFUDiBu40Fw==
Date:   Tue, 27 Sep 2022 10:16:41 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 00/30] acl: add vfs posix acl api
Message-ID: <YzMT2axDeni7L1O8@do-x1extreme>
References: <20220926140827.142806-1-brauner@kernel.org>
 <99173046-ab2e-14de-7252-50cac1f05d27@schaufler-ca.com>
 <20220927074101.GA17464@lst.de>
 <a0cf3efb-dea1-9cb0-2365-2bcc2ca1fdba@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0cf3efb-dea1-9cb0-2365-2bcc2ca1fdba@schaufler-ca.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 07:11:17AM -0700, Casey Schaufler wrote:
> On 9/27/2022 12:41 AM, Christoph Hellwig wrote:
> > On Mon, Sep 26, 2022 at 05:22:45PM -0700, Casey Schaufler wrote:
> >> I suggest that you might focus on the acl/evm interface rather than the entire
> >> LSM interface. Unless there's a serious plan to make ima/evm into a proper LSM
> >> I don't see how the breadth of this patch set is appropriate.
> > Umm. The problem is the historically the Linux xattr interface was
> > intended for unstructured data, while some of it is very much structured
> > and requires interpretation by the VFS and associated entities.  So
> > splitting these out and add proper interface is absolutely the right
> > thing to do and long overdue (also for other thing like capabilities).
> > It might make things a little more verbose for LSM, but it fixes a very
> > real problem.
> 
> Here's the problem I see. All of the LSMs see xattrs, except for their own,
> as opaque objects. Introducing LSM hooks to address the data interpretation
> issues between VFS and EVM, which is not an LSM, adds to an already overlarge
> and interface. And the "real" users of the interface don't need the new hook.
> I'm not saying that the ACL doesn't have problems. I'm not saying that the
> solution you've proposed isn't better than what's there now. I am saying that
> using LSM as a conduit between VFS and EVM at the expense of the rest of the
> modules is dubious. A lot of change to LSM for no value to LSM.
> 
> I am not adamant about this. A whole lot worse has been done for worse reasons.
> But as Paul says, we're overdue to make an effort to keep the LSM interface sane.

So I assume the alternative you have in mind would be to use the
existing setxattr hook? I worry about type confusion if an LSM does
someday want to look inside the ACL data. Unless LSMs aren't supposed to
look inside of xattr data, but in that case why pass the data pointer on
to the LSMs?

Note that the caller of this new hook does not have access to the uapi
xattr data, and I think this is the right place for the new hook to be
called as it's the interface that stacked filesystems like overlayfs
will use to write ACLs to the lower filesystems.

Seth
