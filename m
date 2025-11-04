Return-Path: <linux-fsdevel+bounces-66961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1FAC31B73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3764734ACB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F62221FA0;
	Tue,  4 Nov 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnLbi/Rs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DCC1B0439
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268756; cv=none; b=VvZak0eksbl54NFitlYRiO3We0EC/DjYp6ATvgSerauAtbAw0Oz5ggJExX1+oIJuDr4WWDhD64LMaXjBGXZABcFLi34IwmaLCLQZN7kyk4GBNLbCQFNgWyFZbdlfAnSxkU/p8rIrkUBiLY5g9NPKwIpNLfifVeTOrMX4O4A4Llc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268756; c=relaxed/simple;
	bh=Yp6fUD952UVKQWCkV+hXAOlbW0lYlppgeblWFreQc58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnABb6sqbVnx/a5kOQW12v8uNdT9NwyEcdT68Sm/7PM5AKDpT6LcwaDqEmNLP3kjzH94CO9HXwmHcSxUl/AcraTfXbHvjE2/RJmKo2r84TJtQudKE4qMk/Fw57PNoqdQZTPdUQkdTyjETbEobEC0H9wVqskfQXp2yiG+NtsnXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnLbi/Rs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-294fe7c2e69so52820585ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 07:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268754; x=1762873554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjsZzzSV6ptDEgOqNG45MMGnROqBWBrdMHjfc2PbPmo=;
        b=hnLbi/RskHJ62tG5fmddzuJQ/uUw2ykV9H6PKkLxB3zk/3YDH1Lqh7YLHLEkJNrQNq
         863EdxFMPtKI12/auV2fwyH+VoOfVXWij7zML30P6EuPh6MKhl1AONZBxUj6RPMIvwWG
         iQY6ltYvgiC8Wiu2KP8Lav6z9ic6xHemBuJ5qsRKw+i/wy7HB4F4emkGg2y9xRNTagfv
         GvpFfwYOYoRMVeop2I9At03yO8RqJjC4uLdPGZBYYolHuXx/2kNObyBDvW1w+8oDRW9n
         0ckCEPY9JuNKZqIS4PrSAKjjgiDi/WqTq0i6Tx8w7G+s4wKIhojHlcMGKDAAiW4ZKYdk
         Ak3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268754; x=1762873554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjsZzzSV6ptDEgOqNG45MMGnROqBWBrdMHjfc2PbPmo=;
        b=pfamPzIBZ1JOYLznm3HmaJCDZNTZj/r6gSYm+t+LR/Po8stsZJ4Wt4gn0dtm0iVids
         CJydey0V6TAuPXk525/HJZYWphlC1Cg7xK6i7Fo3tOJasv/J3qYp9BhJW0wTsmRJR7FD
         k+vQvcFyu66zWRyhftfdvlBR+vrbA7jbrxxnZbSR09C4gw1TEtP9HWeh4nCFl2kQeBL3
         CmvTYm0VMtCS9Br8y2COwOOYzKf63POHTywvRtbUpiSdAqS01Wpy2V6CMPwMnG38KDX3
         5gjlSxhnXOwcFrAIM9VOsVktBqcvcDG+9uG0zMCSdRd5TqWM5sqQi4nsmUTMBCM+I8G5
         UJDg==
X-Forwarded-Encrypted: i=1; AJvYcCWaLlUj1aDrP29567hXso+F88qfngRqROl0vAZ1+x+n0jvKrfZH8Ru8gT+s3OGHN0C36WCyChEnfw5RfgGD@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGmsFOWkZlHb5GftoboAdyHRErNcdd/e3v3TXNEOJX5t9A82e
	S//+DsJbW1LOw6tDaxAUgtN++U1j4sRSk52QnSOxBr0PMmolFAc4rpUK
X-Gm-Gg: ASbGncvUp+cKJeiqFoes3Fjx+x8oM5LrL784GX9QnVmciYq7eWHPWa1o2N4JK1/zvUq
	i77lJeGs+M/ldOb2h/1m77VWGWveYb0b26C/xJ97yIeBhZ9Fqxx2JoZzjHVgST4kr1r9QFzgKPq
	5rTaGIvQJGnyP1X/emH2OelyVVRm3fUMCMXHy9gyaC3j9gXAAKdohBdd7yt6oQQaVCCkEVwMhuj
	6GF1tTk0C4uA1wQwcHEcZXbfFw3zCUXP+kbUvpzL4TqCukKD6POwPez1PXILTQ9AonzGJpu37kI
	4v+TzJwrcCogI6LoYAhW+tMMWiUEex6+NiVcXqaWbh9hm8YR8b0kPYvPkNNiA1EGwq8sSNuFdIX
	M/Ccih0zUlbPNVYsVLEI1D8CtZXjYiV2z257bCFlNqMmy3YVYqxw6kQrTo0ypKJDxrLdlS5dm89
	tvkrPwPUURdkfVD/G/kW+9TAFr0y5sG2N1sUEi5LjC+Gn6CGdo6+fKhyawX7LbVChnnUt8oQ==
X-Google-Smtp-Source: AGHT+IF6GMlcuTvJ/QMvT7CMF97mhy83YwPs7iC6oKLK4oKXG45cls7H4Vrjj+0VVpTVu8RpWQY3oA==
X-Received: by 2002:a17:902:d48e:b0:295:986f:6514 with SMTP id d9443c01a7336-295986f65fdmr98727215ad.9.1762268754106;
        Tue, 04 Nov 2025 07:05:54 -0800 (PST)
Received: from ?IPV6:2409:8a00:79b4:1a90:a428:f9f:5def:1227? ([2409:8a00:79b4:1a90:a428:f9f:5def:1227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019982c7sm29883325ad.25.2025.11.04.07.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 07:05:53 -0800 (PST)
Message-ID: <b8f06e62-27dc-462e-83ad-33b179daf8a2@gmail.com>
Date: Tue, 4 Nov 2025 23:05:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fscrypt: fix left shift underflow when
 inode->i_blkbits > PAGE_SHIFT
To: Christoph Hellwig <hch@infradead.org>, Eric Biggers <ebiggers@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-fscrypt@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20251030072956.454679-1-yangyongpeng.storage@gmail.com>
 <20251103164829.GC1735@sol> <aQnftXAg93-4FbaO@infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQnftXAg93-4FbaO@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/2025 7:12 PM, Christoph Hellwig wrote:
> On Mon, Nov 03, 2025 at 08:48:29AM -0800, Eric Biggers wrote:
>>>   	*inode_ret = inode;
>>> -	*lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - inode->i_blkbits)) +
>>> +	*lblk_num_ret = (((u64)folio->index << PAGE_SHIFT) >> inode->i_blkbits) +
> 
> This should be using folio_pos() instead of open coding the arithmetics.
> 

How about this modification: using "<< PAGE_SHIFT" instead of "* 
PAGE_SIZE" for page_offset and folio_pos?

--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -333,7 +333,7 @@ static bool bh_get_inode_and_lblk_num(const struct 
buffer_head *bh,
         inode = mapping->host;

         *inode_ret = inode;
-       *lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - 
inode->i_blkbits)) +
+       *lblk_num_ret = ((u64)folio_pos(folio) >> inode->i_blkbits) +
                         (bh_offset(bh) >> inode->i_blkbits);
         return true;
  }
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 09b581c1d878..72eeb1841bc3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1026,7 +1026,7 @@ static inline pgoff_t page_pgoff(const struct 
folio *folio,
   */
  static inline loff_t folio_pos(const struct folio *folio)
  {
-       return ((loff_t)folio->index) * PAGE_SIZE;
+       return ((loff_t)folio->index) << PAGE_SHIFT;
  }

  /*
@@ -1036,7 +1036,7 @@ static inline loff_t page_offset(struct page *page)
  {
         struct folio *folio = page_folio(page);

-       return folio_pos(folio) + folio_page_idx(folio, page) * PAGE_SIZE;
+       return folio_pos(folio) + (folio_page_idx(folio, page) << 
PAGE_SHIFT);
  }

Yongpeng,

