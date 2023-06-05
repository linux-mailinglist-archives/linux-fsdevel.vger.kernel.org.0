Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F657227E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 15:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjFENxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 09:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjFENxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:53:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC27A90;
        Mon,  5 Jun 2023 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ELSczkhtd9VXMLVlEBA8HALsqT7GXHXhcL7sJaXMFg=; b=GV5IqcIxuEWnfe2y1GOXozlcec
        hCcPFPZz0OwME3BdlN6M9C4ILdh0xSf90Y4as0FYmq4EjTI7qyGK6AhoCMBT6+Cc8KZoyFXlDfaya
        32BeQlpELC5kOi/zMaEYCK0z8gYzeta6lbyTygceNEW80hp2Ce0j6kIKuDySVyYJgO96hi5IffH3P
        5cC7ZTty7oNBpRfLR1Yjp3rWXP2+H8g/TjIZ1bNoJEvnMbH2yqPagF/z7AnKSpGTfZv1WIKCIPHX1
        o7HOvOcjHUaiJ78hi/OahjPduiXw1F6faWWRJbaWLmKz4BfF0I9uPP0E2FMgdXsxsfhd4UkD2rR7s
        IaURQX5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6AeO-00Fgws-0W;
        Mon, 05 Jun 2023 13:53:36 +0000
Date:   Mon, 5 Jun 2023 06:53:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        xiubli@redhat.com, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] fs: export mnt_idmap_get/mnt_idmap_put
Message-ID: <ZH3o4BtG6ufXUnt1@infradead.org>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-2-aleksandr.mikhalitsyn@canonical.com>
 <20230602-lernprogramm-destillation-2438cc92fee3@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602-lernprogramm-destillation-2438cc92fee3@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 02:40:27PM +0200, Christian Brauner wrote:
> On Wed, May 24, 2023 at 05:33:03PM +0200, Alexander Mikhalitsyn wrote:
> > These helpers are required to support idmapped mounts in the Cephfs.
> > 
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > ---
> 
> It's fine by me to export them. The explicit contract is that _nothing
> and absolutely nothing_ outside of core VFS code can directly peak into
> struct mnt_idmap internals. That's the only invariant we care about.o 

It would be good if we could keep all these somewhat internal exports
as EXPORT_SYMBOL_GPL, though.

