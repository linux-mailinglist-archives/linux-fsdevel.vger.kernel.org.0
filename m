Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E6B679141
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 07:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjAXGsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 01:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjAXGsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:48:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F416308;
        Mon, 23 Jan 2023 22:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qK+UI3T20FyKYT+3Yux4NeMa3OKVIXfUbAI0ES6PEHs=; b=lXy6NIdgUN5i+NO3ISveIZxeit
        soM6ieD0NIYSBjBdSGtIx6ZLlKNqdoA30akzbCyc0p8kQVV6o4cOR4olL2RANe+QdT9PJocYiICte
        CBqPhv6thp1gWCsZK63FoCp39tMz62lIUpvOicKLPwBjP31fsvDjFdbfq+u8/P8TWsUxajZSFwuQ3
        Shoc3gKgea71Tne8mJhBPHdmCrNBRcuJaH9ztCJiAcZszDWHPO/Lplp/IzvHFtkliYG1q7Il8Vfn3
        CTJk/GW9tD+CsjuGzWqTp+y0R+eiKBKICfAMg35K95zeh3biaAHR78Mx5cZiZxxCOPJliEm1TXvlu
        rxC18gFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKD64-002a70-0G; Tue, 24 Jan 2023 06:47:56 +0000
Date:   Mon, 23 Jan 2023 22:47:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 10/34] btrfs: handle checksum validation and repair at
 the storage layer
Message-ID: <Y89/G3pybrTTgoQL@infradead.org>
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-11-hch@lst.de>
 <4010e363-33d7-485c-99b2-d5b86be2af3b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4010e363-33d7-485c-99b2-d5b86be2af3b@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 04:39:29PM +0000, Johannes Thumshirn wrote:
> > the following readpage if the sector is actually accessed will
> 
> s/if/of

This is really supposed to be an if - readahead is speculative,
and thus the actual setor might not actually really be needed in the
end.
