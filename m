Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51AB5237B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 17:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbiEKPvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbiEKPvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 11:51:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B055E77F
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mCF/qYx/oMw/g+rz6PuQuam91Y45ofttU4q/t7cEbRQ=; b=cUFR+d8gZi5LXEKcm7GYq25KFx
        +Oi+bE/cBpQo6UeJO1AZpmUDR9ALLtHaGOCXeTC0dUDl170naVkdIfKidVW+rH28jwtmuykYOO9b0
        H+kDCaQz0ZBbJtGGHyVgIgCS1ZKSeiuv30MYKsBKluA0L5i72YGz5X1VuKgGHBHt5LEF/u6SdZLcz
        u0/7BIUk71JEtPbvMBF8IyAhdmKlLw7JFwVxjuQ45lsXTLmuf9dO1jOfFcBhTxyNMMeRurELzzFHU
        KPlXfO8VbxF3NSyhvbsP80P3i+2spMdd+1Q0oMJZnqrhPCXosF7tDev0nujsW3WKGQbos/Osdqcg/
        gSLKTBHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noocg-005ZdG-Sj; Wed, 11 May 2022 15:51:34 +0000
Date:   Wed, 11 May 2022 16:51:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: move fdput() to right place in
 ksys_sync_file_range()
Message-ID: <YnvbhmRUxPxWU2S3@casper.infradead.org>
References: <20220511154503.28365-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511154503.28365-1-cgxu519@mykernel.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 11:45:03AM -0400, Chengguang Xu wrote:
> Move fdput() to right place in ksys_sync_file_range() to
> avoid fdput() after failed fdget().

Why?  fdput() is already conditional on FDPUT_FPUT so you're ...
optimising the failure case?
