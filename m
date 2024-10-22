Return-Path: <linux-fsdevel+bounces-32578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F73C9A9A72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 09:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528B71F22CDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 07:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658541474BF;
	Tue, 22 Oct 2024 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPyin0Ge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C812FB2E;
	Tue, 22 Oct 2024 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580662; cv=none; b=CVQG4Uamxz+EzoeRU7/rkYWZ3AFoerEMMmTBTs/lfe+vUcc8aB8Hz5pvZCrSaI+iOthYwDjk4mYy2Y+GWn1KoLx7XOhQmi3Eau5d4XynmJyeC86KDWFZRU51dJfiXKkOZLlhWdhercQg0Vs2L/n9aG/5krYL9LphfYUKAg/5n1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580662; c=relaxed/simple;
	bh=OiEVx3CyQSZpf4NUvPvORX2CNuIVqlY2rcyiO3dQvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WE9NraPXxgIAVK1R4l7GX5XcA/pWqSIZTjpBFCrUwgPTUlti+acsuYpYUg/BIJbrspyZlKUz0pyGW/LE+slweG8LdYZbYx3onmANyUhEy4BJv5SlUlQxRu5xg+CPF8/oCK+dXsSNP1pJOpnHJxoZU3+nDZY1XWuDtKZdrg+LZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPyin0Ge; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4206477a12.2;
        Tue, 22 Oct 2024 00:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729580661; x=1730185461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHfzn5pEB7+wkK2/3FadNFdG4vjtZSasYVEKemuebak=;
        b=dPyin0GeaYNtnt8kHEYdN6S/wZ6ZttoADw+K/FdTYVEu/TlLRFnl/OyJS+f0ONoM7L
         VGDeQP375T6RU/xrbtd3wIU9JDA897RFSXJxbp7ly1wzhVcxEu1uTM4wemoDJA24drVK
         tEsMhG0ci1hSkA9ga2jj6mUcor9VlUuN+YnFPFsomFKL9uqToVlMh+Ia1dNP/FYnVMHx
         Eolsc9xeW+JA+sshVhiICo1tRHohHskepR+I6wukFMm9KW/VXB2KiEusIPQDVL22Zz89
         gJXsc9sUykGz8dRq8IcFFMlJmOGAE67Kt8JivqDvkPZ4D4Ktq0HZQc4Nw0DIl7mEoTqF
         pcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729580661; x=1730185461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHfzn5pEB7+wkK2/3FadNFdG4vjtZSasYVEKemuebak=;
        b=pi/n5vrJUOHMaEFFC+OZENUZqjXkTtRvuL9KHnpp/ydtT4mqulRhsf3o4UBLFxdvhG
         kieuOEkW2guVDdE6FafsE2ozdFIh7p9Ws0/rZ4dHtoVNXzpouJ8+gn+VPKUlI4iCSdli
         r4SuR+h+DaeTqBBUCFJEeB7eyfRKhYkeLE0UdMHObpT0tUM1xDfoWpmGzampnqmuNyvO
         JW2JjleD3hPQ1iC6mlYxjlLrHOyaYbz7Y8VSYkYOyDY6vZMfEH0KelVQqqp514c6M59I
         IQKcR1bNcNDZX4RzONWhWqQq07th29hO24pJf2ndIg8b0pAigRNnxrhvKWnNE3acJVlb
         9/Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ3N3GSvqC0YdrJN+m0cRVwijnL4dqX5bo+kwUu3zvbJUMwINy0vgG3TxN3Yez/sdWZYC9TYoS+smHe7yu@vger.kernel.org, AJvYcCXx+WosoaSMAZO49Ur1151IBqjTrilSXl0/3o7uHrwoSsGxSLkQRbPAcBWax7dd+1tePemDeuWZ3GkEVWfW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzto6MwUf+QNTYOpnIbZffTx+ip0y4HxbeKQf/IO60cAUVTgKBG
	UaaayXS74ZkH9a+kPMQpIsjUDeZNHybf4ZsTpONlm9NiScZLI1dT
X-Google-Smtp-Source: AGHT+IF64cbuDDlKUTBizTbKS5Lx4E15OLKYjltIONx2T4i3iT8hm96rDTf+1q5jIUe7oGU5r2ivQQ==
X-Received: by 2002:a05:6a20:ac43:b0:1d8:f4d9:790c with SMTP id adf61e73a8af0-1d92c4e013fmr20024219637.15.1729580660603;
        Tue, 22 Oct 2024 00:04:20 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e5ad366cb8sm5323677a91.20.2024.10.22.00.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 00:04:20 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: willy@infradead.org
Cc: bcrl@kvack.org,
	brauner@kernel.org,
	jack@suse.cz,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pvmohammedanees2003@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: aio: Transition from Linked List to Hash Table for Active Request Management in AIO
Date: Tue, 22 Oct 2024 12:33:27 +0530
Message-ID: <20241022070329.144782-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <ZxW3pyyfXWc6Uaqn@casper.infradead.org>
References: <ZxW3pyyfXWc6Uaqn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Matthew,

> Benchmarks, please.  Look at what operations are done on this list.
> It's not at all obvious to me that what you've done here will improve
> performance of any operation.

This patch aims to improve this operation in io_cancel() syscall,
currently this iterates through all the requests in the Linked list,
checking for a match, which could take a significant time if the 
requests are high and once it finds one it deletes it. Using a hash
table will significant reduce the search time, which is what the comment
suggests as well.

/* TODO: use a hash or array, this sucks. */
	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
		if (kiocb->ki_res.obj == obj) {
			ret = kiocb->ki_cancel(&kiocb->rw);
			list_del_init(&kiocb->ki_list);
			break;
		}
	}

I have tested this patch and believe it doesn’t affect the 
other functions. As for the io_cancel() syscall, please let 
me know exactly how you’d like me to test it so I can benchmark 
it accordingly.

Thanks!!

