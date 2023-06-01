Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0560671A104
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjFAOwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 10:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjFAOwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:52:53 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750B7132
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 07:52:52 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 351EqMka013065
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 10:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685631145; bh=ocmgG3AwXqD+xUhaoXDH/qEJqT72EouO1rvjHBr6Htk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VM8/Uu97seftS0qeq+6Ysp9BXkNhjUcaVl9U89FzKjVHN95D2/9uD9/Z0stw6GayT
         TLelYRPi4d2jWT53MdX2oZUfk1PoQcJx+Iz594HiUAahSJ9pKzl9apyvKB/+MjiztU
         bM2Ot+kBWhdNFklD0RSdcbI299bbFE+U8JB76uo6iEoCt4Ql/BS6rmFognIzCNnLq+
         qexrwfUTKnCX32iQ9Da7QywUgvoU0558ckrfhgFf92/Sv7BzpVcMYqbv+yOze6k/Fl
         6vE0tJLu/1VlEkWol5ckl73dRDgvmHCHXBgfYZlYhDQP/K7RMQlgIh7fIpwMQeSXj8
         Is7CFhO77tRDA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4753A15C02EE; Thu,  1 Jun 2023 10:52:22 -0400 (EDT)
Date:   Thu, 1 Jun 2023 10:52:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/6] ext4: Remove ext4 locking of moved directory
Message-ID: <20230601145222.GB1069561@mit.edu>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601105830.13168-1-jack@suse.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 12:58:21PM +0200, Jan Kara wrote:
> Remove locking of moved directory in ext4_rename2(). We will take care
> of it in VFS instead. This effectively reverts commit 0813299c586b
> ("ext4: Fix possible corruption when moving a directory") and followup
> fixes.

Remind me --- commit 0813299c586b is not actually causing any
problems; it's just not fully effective at solving the problem.  Is
that correct?

In other words, is there a rush in trying to get this revert to Linus
during this cycle as a regression fix?

I think the answer is no, and we can just let this full patch series
go in via the vfs branch during the next merge window, but I just
wanted to make sure.

Thanks!

					- Ted
