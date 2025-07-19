Return-Path: <linux-fsdevel+bounces-55509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00250B0B071
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857C31AA3959
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E472877F5;
	Sat, 19 Jul 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCdD8nAq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB016DEB3;
	Sat, 19 Jul 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752935196; cv=none; b=ZVI2qda5ogANCJ/LhUsaGDhZxbhA9A55vhdSiCE+GE2lkiexQwTeAMl0bc0jZwjeBfSVcOW9pcJW6zlOK7v9H3EY1FXxznga//H17+1921+14fJHf9ISfsdr/i4iTgvaLqtenGfPMkiUToT28kP3V6HfuUQE0y31P7kKH9h/61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752935196; c=relaxed/simple;
	bh=Q9VM8+RfTrjN07A2gob6Pf9y9R1h/h3neejkCLSzKKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRvLI40P0A9QSKkIXKce02Nnfv/7tAcWa9Qi1Ftex4idoYkeT8k7KkNvZVmorttG9w3lQHuDDoDpvmEH8mLVB93qZaCjQxvRVZT4TqtSIGxZBWag6hDssAnBACH4x/0xE/Fmz3VbNNk6u0/UIm940m07bSKdQi6FSctbIg1o+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCdD8nAq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso446099866b.0;
        Sat, 19 Jul 2025 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752935193; x=1753539993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/azvO26ioqqebf0mIHfr/fJKozOpQTGU5YXwyKRsJps=;
        b=PCdD8nAqo1B3kyYHPxA+s2IO3NwamEmErvSmVhWuwdkLxaR8FYwrDdGBSVi5lbtWnZ
         FSSGF8M8WB7FxErsO8ljuuYGj/Ro6z2ONsxCGVjgwt4NzUj24EQdv5PShwrWfLgSPZN8
         gISkgMhzNs+I0e2zy8i+DYfYPPBhb3W7BXe5oaRESgm9S/V3JLbeVflf8YTTHkxSBKai
         NemOMJ9pdHxndjctBuMZE5TuNl/K4J8rU7RyhoyA29xyHOQ1LArGyZdomJXoSpsTqprp
         b5nxjhfMWJWBzwt8UZNcBXg1BXRTftZmTs29JUaCeVe4Yd6vH5qfwM1xm/rrGn5k4Gh0
         IOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752935193; x=1753539993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/azvO26ioqqebf0mIHfr/fJKozOpQTGU5YXwyKRsJps=;
        b=Q6bi/dRzViQ3YkAmKHMzedlMXMIuGsTADRRfoaXzsQS216W7kuS3BJUlTwX0S/yhOB
         m0ScojG6zcNLjqaxga64O/WZwrmzWEG5Ho5aaGSXzd3Fpoo+tycfpvkZY2iak3+HvBj3
         +HdmQ6l888xezZTU/z6cm8Cglgfu6a17pavbVmavYgzt1dO8LZoBqC55zV8WUQqgaap0
         +MOMei0j3O8dygiUMV+6KvCWnVt5vP6ZX1mIG/8P9iHhLBY692UXi9h7l2e4QJj5cbXp
         Pit5O0xjKovqMMZftajZBo/H1rL8UKJ0hAiuDuAD+5wTEPIecZgnr6wwotfeaLkeTTtE
         ep6A==
X-Forwarded-Encrypted: i=1; AJvYcCU/FQLfB8pyre9O0wJkXGFrQnHV1kJs+liL7YWRbfhrqT73Zqa/ebyLfKMp+ViM39my1uaPPcPn7/S5JJ/b@vger.kernel.org, AJvYcCUUwlpXrFvjTJx5xhCMUDPR2J+mm0rR2gY17L6Frrtv35dgriyWsCZ9GTxC2Nms1IGr5lA=@vger.kernel.org, AJvYcCWWhoLvRq5eOyPlEfEX3FMzoxNo6KjAYMdpdpVB8Fob106ZuLxq2QZqz7ChY/uqZn1OHPi5RfRIUHRlvO5F@vger.kernel.org, AJvYcCWaflZ/ZJ6+erwRh2euM8Sc9AmNYNd5Ypu4eAxomdpm6N65eIJ3vVMi6crBQ1x8OGbjlv7VYkSAUNAJH1vNnA==@vger.kernel.org, AJvYcCXLiW1fxIipARiseOoVr7/1LRSFpQ3aj1TOwwbY/t2qbOAa+1Czjbn9JayanLfwubDPsmBv2vl1KTdGJn8YwkMR@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyiypG5mhBi8Z63rMnHD76kdiMqu4twVyE43x/BrVfGnLirQp
	Bx1IE/raUEoE18Ee5rj6tfpe2OG0nQV75P8tWPzrjKHoBq6Bnkl+3K4=
X-Gm-Gg: ASbGncu5inb91x6b8pjwqzMAppQzJtqGjSYDe+KJEJiZYxlNoJG4+aSzVMKyoe+G1AE
	UjKE+o73EfXVs7bql2WjSLzP8YlfvWUfJZJoKHG+59p518GhvNyUC2DwR9TRUTNAlkWjlAjRtLS
	vgFb17FiZh5DKAFU819ftseL8DIrbqN7Bq2bGt7iIrXIUgds/wKw5H27Htkye/Duhf5Asyy1Ifr
	HwHaqxh1Wa/aVNoM0f6n5+bDgZkSpPuY/WIdKFPZIf9/Ox+hNDPzhtaa5OerzMdjATtDqAYHySw
	xWWzBpDKn56v5PMN3HVht78CFuIY8pKmPWEuo3BngvbG/2LFT1IIimIUbsJyX4u/cvH60dC6FkR
	pZmRfhnzfKXn3Nxs9F6Td
X-Google-Smtp-Source: AGHT+IH4rIX/bypehArMCYVoJKbKtQr7DZ+CDQF06CuILCUV9Hj7vLhxbEx9C5tE4wNvPK/j+RVLfA==
X-Received: by 2002:a17:907:80b:b0:aec:5516:239c with SMTP id a640c23a62f3a-aec55163f91mr913241166b.58.1752935192840;
        Sat, 19 Jul 2025 07:26:32 -0700 (PDT)
Received: from p183 ([46.53.249.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79ae67sm317872366b.11.2025.07.19.07.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:26:32 -0700 (PDT)
Date: Sat, 19 Jul 2025 17:26:28 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Cong Wang <cong.wang@bytedance.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	David Lechner <dlechner@baylibre.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Gatlin Newhouse <gatlin.newhouse@gmail.com>,
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>,
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	NeilBrown <neil@brown.name>, Peter Zijlstra <peterz@infradead.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Uros Bizjak <ubizjak@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
	virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH 3/7] fs/proc: replace "__auto_type" with "auto"
Message-ID: <63adc48b-9b81-4f35-9462-0de103474d13@p183>
References: <20250718213252.2384177-1-hpa@zytor.com>
 <20250718213252.2384177-4-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250718213252.2384177-4-hpa@zytor.com>

On Fri, Jul 18, 2025 at 02:32:46PM -0700, H. Peter Anvin wrote:
> Replace uses of "__auto_type" in fs/proc/inode.c with "auto".

>  static ssize_t pde_read(struct proc_dir_entry *pde, struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  {
> -	__auto_type read = pde->proc_ops->proc_read;
> +	auto read = pde->proc_ops->proc_read;

Thanks! I'd prefer "const auto" but OK.

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>

