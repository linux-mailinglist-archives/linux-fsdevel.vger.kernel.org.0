Return-Path: <linux-fsdevel+bounces-15612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F48F890BD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 21:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9942A6B09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A654813AA43;
	Thu, 28 Mar 2024 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIB0xJ5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3546BF;
	Thu, 28 Mar 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658797; cv=none; b=Vf/pC+Ynn5vhUkxNORjERh9qMPy3TJSU5SMeQP5bgoogERy6R6/eZFUzwdnlOrirzjf+14kGotPTwW1LC1TQUXVx75CXWjzzaTUAeCD3a+aMcFi2ju6DLCg1Lhj6/s5g3eo38SKzvLnF+mSAUx4oHtVIK8a2/Q2E7Y0RdbiwW9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658797; c=relaxed/simple;
	bh=achoef3ti3RKfcO/Jo2hswTSG/HLiIYtXu63FbpwenQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlVImzl3xOSwlvyuIbDVNgFmUOzS2DLry6mdwTtqJ+sVBUxOVxJNxvAZSN+g3LN7kwU5IJqGDzSCPaywYU1Yj3IBDS3BdpJKwxaqgLU1n7yy6j55EOsTNpOdHyo9NU3OckHJXiA6lxKUEluFgW7MZFeI2v0Wfa1uEjflSvnmRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIB0xJ5f; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso1217424b3a.3;
        Thu, 28 Mar 2024 13:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711658795; x=1712263595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbXWRpIWODvs590Ka3pQExFk/pRq6wGRNHitZbvqgOM=;
        b=UIB0xJ5fGWMCQe7EYMjVR488kwKgiS6shGVZIeXYDeDCFV/W7NlMYKayG3Om44S08R
         buFdgBBdqMuOCDJzPUqYMZGKAKMoQfyFtOgtlPGszDMhnVNn7JOoDuxRQylo2xBZ0UF+
         pUPLzpkSiFr3DeMEPhnz7/lOs2CU63kZlcnXdYzGxYYlfFkcGaASRTxwlFZwgRMT3XQh
         zJ2sRGsoB4Xj3+216iPB3QVaEYwadBYNWjxEp3Hh66WHNZb3z6uksWihS6AZyqiACYJo
         et0LotoVFj+de+fyCRYHIqz+4sA9tDKrZYPztJCG2Un6MKGgpX+KdjwLsiXZdwsz7ypb
         r4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658795; x=1712263595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbXWRpIWODvs590Ka3pQExFk/pRq6wGRNHitZbvqgOM=;
        b=PJkpl3Lotfq3LFhmY+v8xJ8tUNnxVo+CZtLI3NsHSShABUklLnj7Q6kAlpTBjplvy1
         9dv3xSAQE25LH89zgkA11ZjPBnX0RXD8Ci6Qfj1XwhMNfnvnnRzdQfolQ2e0hwg4XDzz
         LbpgQhDPt2EU1f4pIgvOj84waT2FAVfkTJkaV28CXQNsFG6GxJAJXcyjAlODn26gtPY/
         zF0wBJAPZgNyjqbFWQF4/uzrgZyk5/q81dNkRUDa4bIhFaGljro+4gjWBqAF7fEwSwOV
         RyllagczfnK8Ig+Aqt8KIhXbXKKY3Cr8zywVQ0xv9CAAjsQ5qv32J+1InMnMhfbVFV29
         +TWw==
X-Forwarded-Encrypted: i=1; AJvYcCXGUfEkemTiw4ZrZHdWk0+izNQS8vw64N3x57sNAfK/MliykFj7AMqmr+r2EGIYCUAXGoLOE/H6HKJ1v3cCQMpfEjrmcEQ786bcppleHHVLfDKzNnV8mTQz/FgE91m6lOwiWRWKt2dVwVLqhw==
X-Gm-Message-State: AOJu0YxhP6LCKLvQNDiQDtfC+gxtHRD6nFJo8bSqT6FFDBlcUBRhtZsi
	c1/1sYK5E0YiJ1oZns0kCmgwozURJGJY6FqY23Aw6nspFYos4KpZpVsuvDrD
X-Google-Smtp-Source: AGHT+IFOmWQCDUONSdDve2zVQcrYjIwB6pDEs2HXMF9WbYDg5ycopW9LMQsawCPCzAmz7i67RJT6uw==
X-Received: by 2002:a05:6a20:6a0e:b0:1a3:aa5d:8caa with SMTP id p14-20020a056a206a0e00b001a3aa5d8caamr372739pzk.12.1711658795031;
        Thu, 28 Mar 2024 13:46:35 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id i64-20020a62c143000000b006eadc37bad0sm1537852pfg.72.2024.03.28.13.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:46:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 10:46:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
	willy@infradead.org, jack@suse.cz, bfoster@redhat.com,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <ZgXXKaZlmOWC-3mn@slm.duckdns.org>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
 <ZgXFrabAqunDctVp@slm.duckdns.org>
 <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
 <ZgXJH9XQNqda7fpz@slm.duckdns.org>
 <wgec7wbhdn7ilvwddcalkbgxzjutp6h7dgfrijzffb64pwpksz@e6tqcybzfu2f>
 <ZgXPZ1uJSUCF79Ef@slm.duckdns.org>
 <qv3vv6355aw5fkzw5yvuwlnyceypcsfl5kkcrvlipxwfl3nuyg@7cqwaqpxn64t>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qv3vv6355aw5fkzw5yvuwlnyceypcsfl5kkcrvlipxwfl3nuyg@7cqwaqpxn64t>

Hello, Kent.

On Thu, Mar 28, 2024 at 04:22:13PM -0400, Kent Overstreet wrote:
> Most users are never going to touch tracing, let alone BPF; that's too
> much setup. But I can and do regularly tell users "check this, this and
> this" and debug things on that basis without ever touching their
> machine.

I think this is where the disconnect is. It's not difficult to set up at
all. Nowadays, in most distros, it comes down to something like run "pacman
-S bcc" and then run "/usr/share/bcc/tools/biolatpcts" with these params or
run this script I'm attaching. It is a signficant boost when debugging many
different kernel issues. I strongly suggest giving it a try and getting used
to it rather than resisting it.

Thanks.

-- 
tejun

