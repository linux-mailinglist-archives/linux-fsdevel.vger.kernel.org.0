Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC37D114602
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfLERdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:33:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfLERdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2gI7xQVzszSFJZ9xa82hNtLvmnCSRMscbUAe406PQTg=; b=uTBKhzgPZbIat18/rnH6SpmZo
        jWcurEYyVIq3/oT8Nt/Oi4dbQQGJ19+//j0OyK5VTlQpRGEoANe86mg4cjY1VYvitHAGVnU5yqHn5
        lqZ0pokLYIUELdt+TtZ1R14sa8t5AbG71yUrza0nlnun79YSbMoJdHAEyctZzhgCV1zKzkRL2/xdx
        Sefoc9AIZ+BHGYb/d+ulI08zvJ+6AfnHdWPQSIki/uKEcJ36paA5GTkEqF99b97EYvYF9f+1iiWRI
        KLEmegcQRrKSHDaFqkEczWwMphX0bT21MT3TIGEhpDCRNyGRln2xmfr/DH4oINW3rEZsrkcS+YqiG
        Jb2faZ6Gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icv0c-00073Z-E5; Thu, 05 Dec 2019 17:33:46 +0000
Date:   Thu, 5 Dec 2019 09:33:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20191205173346.GA26969@infradead.org>
References: <20191205155630.28817-1-rgoldwyn@suse.de>
 <20191205155630.28817-5-rgoldwyn@suse.de>
 <20191205171815.GA19670@Johanness-MacBook-Pro.local>
 <20191205171959.GA8586@infradead.org>
 <20191205173242.GB19670@Johanness-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205173242.GB19670@Johanness-MacBook-Pro.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 06:32:42PM +0100, Johannes Thumshirn wrote:
> Meaning we do not need to export generic_file_buffered_read() and still can
> skip the generic DIO madness.

But why not export it?  That way we call the function we want directly
instead of through a wrapper that is entirely pointless for this case.
