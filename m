Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF682717B20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 11:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjEaJFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 05:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjEaJFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 05:05:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B5113;
        Wed, 31 May 2023 02:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 541D3634A0;
        Wed, 31 May 2023 09:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34978C4339B;
        Wed, 31 May 2023 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685523900;
        bh=2sYByOARuvzs0xgoeOJuHM0JAfAc9I7u2R3Ei6WHdos=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CE7/pk4wQuSL/LNwZaW//4y9h+8Ah0nBiwA+2FoZoRqH0P2XxGiZKvU7Kwwk6Dtou
         H+PPHOTbJeg0iKHcdZ2xTbNZynpgF1LhJskFjKGy6JDuJ/8rE5Fpz04rx52BcFAOuK
         4BJtQ1OuWZ7h+DwdRnfpwel8tJ2fU9pAj2QIwThNCyXFiIknEmCrCy0WLFIdVaBYDd
         vTE3Rz4LPpzpIlv1XQqVzOT5Yw98nChI1BwgSQ7v4WEb59quF5XQ2IXYyBnrlU1LUe
         CKwK/+1voe/mi+ut/8w8Yk+gZ++ZWpoHyrsn3GEKlYPI1djuVNEsMeuqS+hgOaxhTt
         LKYHh3lZAHhNw==
Message-ID: <f182cd69-2553-18bb-5908-966209bb313b@kernel.org>
Date:   Wed, 31 May 2023 18:04:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 01/12] backing_dev: remove current->backing_dev_info
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
References: <20230531075026.480237-1-hch@lst.de>
 <20230531075026.480237-2-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230531075026.480237-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/31/23 16:50, Christoph Hellwig wrote:
> The last user of current->backing_dev_info disappeared in commit
> b9b1335e6403 ("remove bdi_congested() and wb_congested() and related
> functions").  Remove the field and all assignments to it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Nice cleanup !

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

