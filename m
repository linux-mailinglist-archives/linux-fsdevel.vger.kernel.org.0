Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB17C591910
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 08:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbiHMGs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 02:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMGsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 02:48:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6B315A2B;
        Fri, 12 Aug 2022 23:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EKZ7iw4o0Vgf8sOuHWGlEefJp/oYHiqjhthkGTQEp8c=; b=n+eUEbGe4rcqum4+1jsQXTTIvC
        EYkAjAWh2nqUZVGhTvAVlfhHItCOANRd3yEf30tOJAy5+i+RxDLXXiiD162iR4bmdDaeTJBKilI1u
        eFNVIzPrs4kDMQWABDrMN5EPJX5tXivlZaZLlmscu8sDQ3O/mllPyEML9nfUt7yg4stkrn2wxJfiY
        jEVylR09KZegI4gMBN1JPBUIDPIHuS3GeWKgw8fiNzfJKWYmgWL9lXGtwLNsV7aNJURBsz0XfrZ/u
        pPMDXM/ovVewtvWQdFf51Gx7E7PYM68DqcDt8BqKdWewleCJ5oymabMcQMJqCESW344ePGZCUtJQ/
        w3jUaZKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMkwU-006hLO-7k; Sat, 13 Aug 2022 06:48:18 +0000
Date:   Fri, 12 Aug 2022 23:48:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     viro@zeniv.linux.org.uk, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] fs: fix possible inconsistent mount device
Message-ID: <YvdJMj5hNem2PMVh@infradead.org>
References: <20220813060848.1457301-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220813060848.1457301-1-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 13, 2022 at 02:08:48PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> If device support rename, for example dm, following concurrent scenario
> is possible:

The fix is easy:  don't rename mounted block device, and even
bettersimply don't rename them at all, which is just causing huge
amounts of pain.
