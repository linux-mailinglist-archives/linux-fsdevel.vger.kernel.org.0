Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4879E78F8B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 08:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348398AbjIAGtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 02:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348397AbjIAGtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:49:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC2DE7E;
        Thu, 31 Aug 2023 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PA+yNU4lPn9KieY83YfnLjgiFKNzsnzdpdHO0b2nVFs=; b=CcIUGfC6963GwJ4rFhGTRJxf5i
        u5bGK54JOuEuzE9vY5sPmxb7Rd8MR+iSFQftbM01j2aL3KLkkHKzaVFDc1sAFy7/7fWOwRrZWDHoD
        8VyyHPjgscpxr9vCqpUTVeDmDQZX1y6sgM9OwvQ0jsjCbnpWnooOqbo4bPSby/Z1UnMBP9Z6i9iWQ
        8o6zhlX/ru1bFvG7M40SsHyOvo3a+0m0SXSLTeJwtPF6DbHSdjMKJDHpxdAjI4jyexPVNCR4WW7ao
        8MWHiD/z6zkjigjTvpCkSosd0L+K9R8WCYnkOHbbm82FTLz9f356DZghcxlEzIxBwy0e2+e20ll0u
        hvJa4nug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qbxy4-00GZ85-2F;
        Fri, 01 Sep 2023 06:49:20 +0000
Date:   Thu, 31 Aug 2023 23:49:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/2] Use exclusive lock for file_remove_privs
Message-ID: <ZPGJcMy+S2DjYutF@infradead.org>
References: <20230830181519.2964941-1-bschubert@ddn.com>
 <20230831101824.qdko4daizgh7phav@f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831101824.qdko4daizgh7phav@f>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:18:24PM +0200, Mateusz Guzik wrote:
> Turns out notify_change has the following:
>         WARN_ON_ONCE(!inode_is_locked(inode));
> 
> Which expands to:
> static inline int rwsem_is_locked(struct rw_semaphore *sem)
> {
>         return atomic_long_read(&sem->count) != 0;
> }
> 
> So it does check the lock, except it passes *any* locked state,
> including just readers.
> 
> According to git blame this regressed from commit 5955102c9984
> ("wrappers for ->i_mutex access") by Al -- a bunch of mutex_is_locked
> were replaced with inode_is_locked, which unintentionally provides
> weaker guarantees.
> 
> I don't see a rwsem helper for wlock check and I don't think it is all
> that beneficial to add. Instead, how about a bunch of lockdep, like so:

Yes, that's a good idea.

