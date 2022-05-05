Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBB051C703
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 20:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356252AbiEESUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 14:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383121AbiEEST3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 14:19:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DC218E10;
        Thu,  5 May 2022 11:15:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E4CC68AA6; Thu,  5 May 2022 20:15:44 +0200 (CEST)
Date:   Thu, 5 May 2022 20:15:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] iomap: add per-iomap_iter private data
Message-ID: <20220505181543.GA814@lst.de>
References: <20220504162342.573651-1-hch@lst.de> <20220504162342.573651-3-hch@lst.de> <20220505154126.GB27155@magnolia> <20220505154557.GA22763@lst.de> <20220505163219.GJ27195@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505163219.GJ27195@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 09:32:19AM -0700, Darrick J. Wong wrote:
> > No need to transfer it back.  It ist just a creative way to pass private
> > data in.  Initially I just added yet another argument to iomap_dio_rw,
> > and maybe I should just go back to that to make the things easier to
> > follow.
> 
> Hmm.  Who owns iocb->private?  AFAICT there are two users of it -- the
> directio code uses it to store bios for polling; and then there's ocfs2,
> which apparently uses it for iocb lock state(!) flags.

Yeah.

> Getting back to iomap, I think the comment before __iomap_dio_rw should
> state that iocb->private will be transferred to iter->private to make
> that relationship more obvious, in case ocfs2 ever stumbles into iomap
> and explodes on impact.

I think I'll just look into passing an extra argument instead.  It
is pretty clear that using iocb->private was a little too clever and
takes experienced file system developers way too much time to understand.
