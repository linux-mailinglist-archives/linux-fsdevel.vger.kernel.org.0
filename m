Return-Path: <linux-fsdevel+bounces-27350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88F29607EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B69283E88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA119E82A;
	Tue, 27 Aug 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BBbMK35P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706CB674
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756043; cv=none; b=n6glErUXB3Tqly2aptkv8ZWe1r6BuPDEI/S8tMsUzC7uWQ7pJXF4PDYGf+5RF00QTuFhcDWPySIz1/DTf4A6ZDRLPBTne6aqVcqBCswejqHUEt6XSsvG/aR5AUDbGMRs0pvNCyNwUxzPms7KNenduHcZnUWORbIQYh+uoE7/shA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756043; c=relaxed/simple;
	bh=OIj58p9z7PV/B67T6gypj3fNfOS7T78tyJTwBuw4LCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijEp/vx9Kng/D9WIxpzE6yFoEXOEmQotV/YonOYotfZBBJVs5XrE5vDGd/+IhOJUQETgTtMR157PdF3vUydvBytUMOZr8VQfT+b4GgphZz3Gs3DKKZeOBtmsB2c6+/cK9oXHsZSthfiEPAPd3oZXjrhF5239drW5OuZx6JbAnL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BBbMK35P; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86910caf9cso864847566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724756040; x=1725360840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2+li/AcO6Ae1QDTZoYlXn07+RgNIMHrKujTKXnZVo0=;
        b=BBbMK35PkxYByELaBa1CGWfW9sUlRE+9B/LnbIXN5AWLvxMQK3BPMntBo/VmTs6oAH
         gxARpSAkgitHumIzpyyV+CyGwoqj7/GUj2UZZ+xYIAJd3MpLfzkBEWDofKBM/MQASu1M
         0/ngdfKRABPBHK2PSF3rcS26Wx/SrAKSJXfg4C3ne27pYq5NG3/lfE7oR1Js3//bw+60
         OKSOFAVcWhF7gIMKySc2rSwI4VTA6cEJAfBDxvH82U2FFUKUirUMSzj7Db2cfyweXy4Y
         BdEsabvVW3cINJr7TBmikcbY1j0yzNyc7iZzNpC9a1m1oolv9kDUSM2uAn6xyCUv5wBZ
         uy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724756040; x=1725360840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2+li/AcO6Ae1QDTZoYlXn07+RgNIMHrKujTKXnZVo0=;
        b=h1BTGuYPEQvCkDsNyDcknw8yMKvrNXiQkD9aUxdvWD7g0pzsbT8hlbLo3u1bfgh1YL
         bf9URIIgL0FtnqyHrVyjwvN1bMguNUw06gUV9WRLY+gHMqCKp73nKd+j0k+mFe87c+ab
         z8tEdLG5NpgaPrtbfYuqlL1s4Ek0NwiG+mZ1RkcBuoI/6hfTNY0UpYbHo3R1V+vGT2u8
         XsrG/mmZXQlJOnlbMUsmwQ/8/nuNiQXGFk2IGDbDeF7kCPoZhkEKoUrNfLskG4q2JbMS
         nv0SYrHiPnmqPMJxkI/vkMKZ5uKTAaQbDhisZijj2eOMnxrNgEUVYo2oHthpKLTv6Vsr
         ulpw==
X-Forwarded-Encrypted: i=1; AJvYcCX9jZDMyX+gdpbhIwdCY3Z6ksPDLzJIapdUfpXiHnpvVBuhhfX7ZoMbniuLe2Tpp3RFq6x3c75o83QJ4R4v@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcaI34AhJ5ATOCoOcphFMOdVayKVZSpZen7IOjdBf78D5SCx0
	wKAr5+hWD1ts5lcR6pyYXovXR4RhQvSZ82eUfj0q3t50s8hfRyO8h5/76+DOvYSStuE/HuWrAdO
	f
X-Google-Smtp-Source: AGHT+IEjFrTYI+AqR+e7VmGfKsN/nVI/pn6+NZveY9Op2DOsbXHXpZ55OtFZDF3A7ozw2wnssRp8JA==
X-Received: by 2002:a17:907:94d0:b0:a6e:f869:d718 with SMTP id a640c23a62f3a-a86e29be930mr257003266b.21.1724756039983;
        Tue, 27 Aug 2024 03:53:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e58a57f1sm93454166b.187.2024.08.27.03.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 03:53:59 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:53:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.11, v2
Message-ID: <d0da8ba5-e73e-454a-bbd7-a4e11886ea8b@stanley.mountain>
References: <73rweeabpoypzqwyxa7hld7tnkskkaotuo3jjfxnpgn6gg47ly@admkywnz4fsp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73rweeabpoypzqwyxa7hld7tnkskkaotuo3jjfxnpgn6gg47ly@admkywnz4fsp>

On Thu, Jul 19, 2024 at 06:36:50PM -0400, Kent Overstreet wrote:
>       bcachefs: Unlock trans when waiting for user input in fsck

Hello Kent Overstreet,

ommit 889fb3dc5d6f ("bcachefs: Unlock trans when waiting for user
input in fsck") from May 29, 2024 (linux-next), leads to the
following (UNPUBLISHED) Smatch static checker warning:

fs/bcachefs/error.c:129 bch2_fsck_ask_yn() error: double unlocked 'trans' (orig line 113)

fs/bcachefs/error.c
   102  static enum ask_yn bch2_fsck_ask_yn(struct bch_fs *c, struct btree_trans *trans)
   103  {
   104          struct stdio_redirect *stdio = c->stdio;
   105  
   106          if (c->stdio_filter && c->stdio_filter != current)
   107                  stdio = NULL;
   108  
   109          if (!stdio)
   110                  return YN_NO;
   111  
   112          if (trans)
   113                  bch2_trans_unlock(trans);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^
Unlock

   114  
   115          unsigned long unlock_long_at = trans ? jiffies + HZ * 2 : 0;
   116          darray_char line = {};
   117          int ret;
   118  
   119          do {
   120                  unsigned long t;
   121                  bch2_print(c, " (y,n, or Y,N for all errors of this type) ");
   122  rewait:
   123                  t = unlock_long_at
   124                          ? max_t(long, unlock_long_at - jiffies, 0)
   125                          : MAX_SCHEDULE_TIMEOUT;
   126  
   127                  int r = bch2_stdio_redirect_readline_timeout(stdio, &line, t);
   128                  if (r == -ETIME) {
   129                          bch2_trans_unlock_long(trans);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Double unlock

   130                          unlock_long_at = 0;
   131                          goto rewait;
   132                  }
   133  
   134                  if (r < 0) {
   135                          ret = YN_NO;
   136                          break;
   137                  }
   138  
   139                  darray_last(line) = '\0';
   140          } while ((ret = parse_yn_response(line.data)) < 0);
   141  
   142          darray_exit(&line);
   143          return ret;
   144  }

regards,
dan carpenter

