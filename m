Return-Path: <linux-fsdevel+bounces-17387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3B58ACB8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 13:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFBD1C220D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 11:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6251145FF8;
	Mon, 22 Apr 2024 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7CbiFjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FC1448C6
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783591; cv=none; b=atT7O2Yso16frrK9pxB8DBwAddQ8JfJKvRC8uQeO9ykoYoAoED2LZjKhihmdlBsLKZTBQQShtN+du3pzUrjbs9Vu9GZeTCiteiGyAGEs8FPyrqOZ76+iz6esplCFx/CSSMesyfUlZ3/0zlQP8L9+ZtsWGNCKnzO4yyqpCykEz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783591; c=relaxed/simple;
	bh=ByV4wx53F+Bj/sWnR1/+e1rmbKucboVx+VWJQOUFgV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GT5qt8bF4f5oQiNeph1ivgNfp4/lHstUO8vkiSA9d5oBJzWSv6DMlC4SzLKYQlyudnE75vnFPUd8DlIz2BqwI0V8ce3pc5odFyPEQk9OKcid+T5wC9Qvm47yoO3E8YGgDARwjq7rbeTUQU3g2ZwOxZ1k6kBI3JBZkMniGbhhsQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7CbiFjs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713783588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkaTsvApX7Y5+uul/atpw/w4VkhhXsSJVcui3j6Wmlw=;
	b=U7CbiFjsdcChlAcXQKkhg5e3PBMhsbulpLnAhN2U+/YIJ0M9PCoXya57Q68kVken0/RO+/
	GLRbPhkL9SWEaBEXa5vI0phTgdbhKn+yE+EJnG6DNivd3T+J2z2MvO1cEa9WjHovmIzTOM
	4sGBiKLKtQh80F6Vm5dRZcO/m2kB9Ms=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-H5fi2Hq1McG1tNYKLu7MuA-1; Mon, 22 Apr 2024 06:59:46 -0400
X-MC-Unique: H5fi2Hq1McG1tNYKLu7MuA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a5217f85620so221405266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 03:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713783585; x=1714388385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkaTsvApX7Y5+uul/atpw/w4VkhhXsSJVcui3j6Wmlw=;
        b=FBEp6zRp4zNERzTub8JVYL1nyfMfuEICCgwXLrMhLB+P6nbCQIDub9tfbeZ0J+Wu5k
         rXKlfdRo8ADKZMfg5ghgfk9DoRYMQwgfgADI5N01E0pZvv8SC8uBEyQGz9OAzbeKfawj
         vJC4jZl8EQHcxHfcZq2p939KNLm2k1lUXWSxFt3PBWhy9XDs5rXOGeU6VrplX5RtCyb8
         G17Pdt5CMtA+YQCuV6WCMJbptgtPX56doY5vyLkt0ppjwmtqrIrC1MtQWr1skkQ/wW4M
         PBSRmwMpy7sEtOfXRlB0CsC4C3+ciwDFNNioI0VKmylwsC5DtvvsyDd8fXRF/Vhs3Nwf
         CLSA==
X-Forwarded-Encrypted: i=1; AJvYcCW2ni+pbA/L/FO2QuSiiR73scgI8bwPEhELQdXWFMeQ6c8sr0HfDqJTDam8pfcMufednohA19kdjcR03P28Y8hVAJww8oLwmySXNmXC7g==
X-Gm-Message-State: AOJu0YzFD8KdlLnzwlzFtNeYTjXJ7lvSuelI/ZdKZRqAHcb5Zeyn6vGy
	AYyTc8h86dzAgIJNjyUwjnghvjt673uAbUUREB79rPXf9PmXPgTQD6Tcz9pbAlwC6FAf6LSX1bK
	WHhO9DYJWGwC/IhdkkpPjkNA9RdGo1pFnbr//5pQnon7Q1O5y/X02mPRNwJShp9xf+HI+CgayUQ
	==
X-Received: by 2002:a17:906:c290:b0:a52:1e53:febf with SMTP id r16-20020a170906c29000b00a521e53febfmr5730574ejz.69.1713783585269;
        Mon, 22 Apr 2024 03:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEow5wFlraT79dbPyyqpKfukpAIzRPIWgxDZUxghIBeayl6l6hWtQULh11HV6BKBunNeV2UzQ==
X-Received: by 2002:a17:906:c290:b0:a52:1e53:febf with SMTP id r16-20020a170906c29000b00a521e53febfmr5730558ejz.69.1713783584919;
        Mon, 22 Apr 2024 03:59:44 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id q21-20020a170906771500b00a51d408d446sm5631153ejm.26.2024.04.22.03.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 03:59:44 -0700 (PDT)
Message-ID: <dfb466f0-fc09-491b-af35-9c315ebd74eb@redhat.com>
Date: Mon, 22 Apr 2024 12:59:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/30] vboxsf: Convert vboxsf_read_folio() to use a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-26-willy@infradead.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240420025029.2166544-26-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Matthew,

On 4/20/24 4:50 AM, Matthew Wilcox (Oracle) wrote:
> Remove conversion to a page and use folio APIs throughout.  This includes
> a removal of setting the error flag as nobody checks the error flag on
> vboxsf folios.  This does not include large folio support as we would
> have to map each page individually.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/vboxsf/file.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
> index 118dedef8ebe..e149158b105d 100644
> --- a/fs/vboxsf/file.c
> +++ b/fs/vboxsf/file.c
> @@ -228,26 +228,19 @@ const struct inode_operations vboxsf_reg_iops = {
>  
>  static int vboxsf_read_folio(struct file *file, struct folio *folio)
>  {
> -	struct page *page = &folio->page;
>  	struct vboxsf_handle *sf_handle = file->private_data;
> -	loff_t off = page_offset(page);
> +	loff_t off = folio_pos(folio);
>  	u32 nread = PAGE_SIZE;
>  	u8 *buf;
>  	int err;
>  
> -	buf = kmap(page);
> +	buf = kmap_local_folio(folio, 0);
>  
>  	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, buf);
> -	if (err == 0) {
> -		memset(&buf[nread], 0, PAGE_SIZE - nread);
> -		flush_dcache_page(page);
> -		SetPageUptodate(page);
> -	} else {
> -		SetPageError(page);
> -	}
> +	buf = folio_zero_tail(folio, nread, buf);
>  
> -	kunmap(page);
> -	unlock_page(page);
> +	kunmap_local(buf);
> +	folio_end_read(folio, err == 0);
>  	return err;
>  }
>  

Thanks you for the patch.

I have this a test spin, but I got all 0 content for the kernel's README when trying
to read that from a directory shared through vboxsf.

I came up with the following fix for this, which I assume is the correct fix,
but please check:

--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -237,7 +237,7 @@ static int vboxsf_read_folio(struct file *file, struct folio *folio)
 	buf = kmap_local_folio(folio, 0);
 
 	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, buf);
-	buf = folio_zero_tail(folio, nread, buf);
+	buf = folio_zero_tail(folio, nread, buf + nread);
 
 	kunmap_local(buf);
 	folio_end_read(folio, err == 0);


With this fix squashed in, this looks good to me and you can add:

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Feel free to merge this together with the other folio patches from this series.

Regards,

Hans






> @@ -295,7 +288,6 @@ static int vboxsf_writepage(struct page *page, struct writeback_control *wbc)
>  	kref_put(&sf_handle->refcount, vboxsf_handle_release);
>  
>  	if (err == 0) {
> -		ClearPageError(page);
>  		/* mtime changed */
>  		sf_i->force_restat = 1;
>  	} else {


