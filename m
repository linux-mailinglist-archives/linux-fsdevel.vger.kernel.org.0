Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8182E494A41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 10:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbiATJDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 04:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiATJDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:03:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F2FC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 01:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y2zYnBm0wP/+YwbVnWq1HASe5FpONaBIprYc1hCmhss=; b=0FHDV/KlbZqCEohdVPCW2G3peI
        X6QMlAncEHl65/vFKSCYlvxy9DAqIooFJLZxOk03MDbVUsxn9zM5/ka5LZpnA78R4H/4E7TtYwZrr
        xHYh//NysGiTXvB56yn0q5b2KJvHi673kj310QLBrGCjezkjSDobtiO8jto7dUeyjcLYqzg2p55Jy
        MBI7lsutMGvIF6xTZgtiS7b0yXrEMgyy6ALOrGZ0u2n8TpLCWomTxb27g5nxPUYxWCooqbMNxvYt/
        ijJgg03kho3HHBZFcYnGSnPjtLQCYYx5TFID+WkPmmAfmNSM2SEC7EqxaF4ghURffFdf/zoPswMXW
        hqNX2PIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nATLd-00A1hT-Bf; Thu, 20 Jan 2022 09:03:13 +0000
Date:   Thu, 20 Jan 2022 01:03:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     chenxiang <chenxiang66@hisilicon.com>
Cc:     bcrl@kvack.org, viro@zeniv.linux.org.uk, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] aio: Adjust the position of get_reqs_available() in
 aio_get_req()
Message-ID: <YeklUcOCM4W38siT@infradead.org>
References: <1642660946-60244-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642660946-60244-1-git-send-email-chenxiang66@hisilicon.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 02:42:26PM +0800, chenxiang wrote:
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> Right now allocating aio_kiocb is in front of get_reqs_available(),
> then need to free aio_kiocb if get_reqs_available() is failed.
> Put get_reqs_availabe() in front of allocating aio_kiocb to avoid
> freeing aio_kiocb if get_reqs_available() is failed.

Except for the fact that this completely missed undoing
get_reqs_available, how is that order any better?
