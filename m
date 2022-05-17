Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BF25299A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbiEQGjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 02:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiEQGjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 02:39:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E3944754;
        Mon, 16 May 2022 23:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=redkslta1XvbIHyxCsjCWY1VUKS1fGAK120a9dVCqE0=; b=2VYsal265wSEt0XMzRpPZMcSA4
        XbHkNSnYJq1bRT6O2KxYYXv+FHMr4fyA2sYLg53IxwbLs1fy9Re2VxvsCTcrs2aITGnRUyU476qqs
        kS41e5h71jJLrd3a3DCAXlozCjCfMVWrrxMG2418qC7qxNoFeRZ+cr39PJzXhuIsQhSarm5OuXTCt
        UktoQti5EW6KTZ83iO+h3Tfc61N06/n5bRfp3Lxu2yizLKYk8KqsDIaTrL/fjKb4IuFGSaaSjQUwT
        RmZnBy10Sq60H9WqL7DHP+ASkj6mtUJjFrekTPXKKHRTUTuFTJQxWhD0utjqn8XLwrFYfhY6hUjw/
        S+vTbMrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqqrD-00Bq3d-JY; Tue, 17 May 2022 06:38:59 +0000
Date:   Mon, 16 May 2022 23:38:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sparse: use force attribute for fmode_t casts
Message-ID: <YoNDA0SOFjyoFlJS@infradead.org>
References: <1eb3b298-4f7e-32ad-74ae-12044ed637ed@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb3b298-4f7e-32ad-74ae-12044ed637ed@openvz.org>
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

Please just use __FMODE_NONOTIFY instead, which might be a bit misnamed,
but was added exactly for this kind of use.

And remember once more:  __force casts are a massive code smell.  Never
add them before thinking hard about them and adding a comment explaining
why they can't be avoided, preferably in a dedicated helper.
