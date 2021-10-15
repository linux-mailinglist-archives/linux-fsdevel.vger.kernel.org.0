Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC942F20D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 15:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbhJON0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 09:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbhJON0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:26:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4B1C061570;
        Fri, 15 Oct 2021 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Vf35v0bqiZzdiWrXKHoxlWqdW5cbp+8y9iPSBh82fTg=; b=20134lrxVbhWLR74xnpZwFl2LP
        MFiVJpXssduTGdPS5Ydo2aYJ1BJiBhUjQ3glVfIgIICFRofxfIbNZuYf/ROs4LyoeIDZb98e+JDD8
        zurbvXysVzqrxNrpe4EYfMwDkHj3smo938qwbOCgcE2TPLQZOG6F5XbotvFb9fAvPdbmRDsDrHV2t
        NZB9X0gnYB4CELZE7XXTNCSvoojH9DO7L65UGwxS/oti0YkDdymrV7KuAGvH4yl8S/pu5DHGV6/do
        2+HaZVf2PecgUha6qUWUun53JR8YGo6IiDrPMOGTBv9JxL2sSzlP5TWYxYpBUCZZY/8d09NO4xnqm
        JCxfl+hQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbNBs-007Bod-NR; Fri, 15 Oct 2021 13:24:04 +0000
Date:   Fri, 15 Oct 2021 06:24:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
        akpm@linux-foundation.org, sunhao.th@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: inode: use queue_rcu_work() instead of call_rcu()
Message-ID: <YWmA9OQgPHlZt2lx@infradead.org>
References: <20211015080216.4871-1-qiang.zhang1211@gmail.com>
 <YWk195naAMYhh3EV@infradead.org>
 <bcc1c2ec-e3f9-34b2-659e-b71fd149f677@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcc1c2ec-e3f9-34b2-659e-b71fd149f677@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 04:28:10PM +0800, Zqiang wrote:
> 
> On 2021/10/15 下午4:04, Christoph Hellwig wrote:
> > NAK.
> > 
> > 1. We need to sort ounderlying issue first as I already said _twice_.
> > 2. this has a major penality on all file systems
> 
> This problem report by sunhao,  the log
> 
> https://drive.google.com/file/d/1M5oyA_IcWSDB2XpnoX8SDmKJA3JhKltz/view?usp=sharing

When I wget that it just returns garbage unfortunately.

> 
> but I can not find useful information, not sure if it is related to the loop device driver.
> are you mean There is a problem about inode lifetime ?

Yes.  This implies that the del_gendisk hasn't been called before the
block device lifetimes hits 0.
