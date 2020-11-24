Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9DA2C2EBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 18:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403839AbgKXRhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 12:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733153AbgKXRhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:37:10 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B24C0613D6;
        Tue, 24 Nov 2020 09:37:10 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f15so13163782qto.13;
        Tue, 24 Nov 2020 09:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RUiSFwuqBx5Z5RkIMV/LAo3IZ2wMWa1pe8Bi01kcv9s=;
        b=I/ritBavAlEmXZYTdxsCZ3TKkeS+XbD2T5fSeuu+WAKjEs5fvGA2bMQkLo5MtRefva
         qUl8yUxkVj+bBWUkgYhVfKpDhiO82hph16AQ0vGX7y+wlrcH9EWYcgfJQ+ri5yzcT/jj
         ur3RBED4twIKVJJFDo/q0nmklKouT/Ot6KY5VSp33Mrn+/sIul4sQvPJjUYsLJ8PVoUi
         uTUrhLlViP7uzPXo9Qlf/lrWs/mwSY/bN6T+YIT4kadfNOZMSiRbHdqwLGtEwY2FNG+a
         TyAacskIalN0dBCzTDwuIzKGsDgNK5Z2Dd7niqvvN6G5G9OXmjSjKHmLzT22iYm6LIXb
         z2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RUiSFwuqBx5Z5RkIMV/LAo3IZ2wMWa1pe8Bi01kcv9s=;
        b=QbL+amkyjRGsPzSHoqlUmj2p+MDb7sZxLxGNGiicJG7o45ptI2T1w0IJ0OFQhyoK6i
         s5lxXiebV+xZrrzcrjp4AzW/fEsSAusjh4XiKEhOJDPGTWnbBxpeXDFSsjiPAjUUNVtm
         SayyEX5AzBGnsM1HyUuG6rhiMnNcFoQS6AIy4SJvdOEDLtaO2RICOL4hPXLcUTP6lmRE
         mKHlrLjxnUG7c0Tt2+QfKT3RU6KrKX7+kvZOGEmMgyOQsqBk76bdCc/kgJCRfTYLVbhE
         nSshEKOsjpnfhAGTelQtkSdD917JBkYCA3XhIRKblg3v/NucafAEDI46+G79px8Jsp6u
         /IQw==
X-Gm-Message-State: AOAM531cCXwAn+is8U/5Q/z7/eNf7i6RHIUB8tiZUFUJFNYNnDAoe7d1
        vnrsEDm+fTWegXSWPdUAjPA=
X-Google-Smtp-Source: ABdhPJzns9py3D52IrNBrxEn0rk+MGg8bhauWe2r/6sVRsp+lUoI9EtR7DOBSR7jcCHuxmdt3gs4iQ==
X-Received: by 2002:ac8:4802:: with SMTP id g2mr5435506qtq.235.1606239429633;
        Tue, 24 Nov 2020 09:37:09 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id 137sm13319731qkj.109.2020.11.24.09.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:37:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 12:36:46 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 11/45] block: remove a duplicate __disk_get_part prototype
Message-ID: <X71ErqPWQu+CvXRI@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-12-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:17PM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
