Return-Path: <linux-fsdevel+bounces-69830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 732D2C86A21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 19:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7E12352FB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB633122E;
	Tue, 25 Nov 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYGZ5fqB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967332AADD
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095491; cv=none; b=QtktB1ejdatwEN91V+8hZRD2abPQsBT9XuhfJqE007FhwolCN8LPFZ6Odf5tAs1t/nPFJ9nUQWpDN73Mf4t64YRu68cjN99i8R7QPeY/wVCTbDm/fpSCm21OKad2ymUO8nZ6b7yVUciFckPSAEF5MxaKzEBPkrdLEyTpqEaSjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095491; c=relaxed/simple;
	bh=5tz2aAHBD7vTNYLjZkzJH3s9gWYpFddvilCC/4yN7Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWwnDd5ps+CzQpMchXERwHSA5IcW38qNX7mb/49a2Mv794dgDnaJGsxJ1WMZqz1FZLTP6xgld5aUqI8znJ5gGW3ci2o+XUk+7Zm3I3CGfEhz0Sh57dwIbXiaKW0zaVhY6w0V4/RBxa18OVZ9n3VV7hT0w8fDBrVQr9/HpZYC2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYGZ5fqB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2958db8ae4fso60278005ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764095483; x=1764700283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7O4GSlYSAloya2gWAKt06Wd2oP8bRALkgcDobg98SWs=;
        b=aYGZ5fqB44pcrFVN8TRn947PWEw4614zXbXiJ67T3hNxZYwAWtkslkYq+4QZAL9ZHU
         Xz2/Kb/GUjT/9T92647u39aYnmz30z3PMv4eSjIcimJbMlc5YfdGxkD9iQJUmzpo7YAk
         PoEtFVfyeHuMFC1znRZrd6Y82Mg5WtEVct9WxztFv3T86rPp/MPuVMvq2MsZp47Io6RH
         Uxa8LWtwTSUi4Mac1UDbAbpjUbyIKHp0OPMKw//ygq16YYazGu7ZsaehloVTbOXe6NYY
         39SbxX6P7TAsIyRlooEfamSOE/nL6mzozue0sa7zLXvBkZyNP6io1RQQPRFp8nC6J7Fh
         /l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764095483; x=1764700283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7O4GSlYSAloya2gWAKt06Wd2oP8bRALkgcDobg98SWs=;
        b=dEHSNJbMQILw2PP3ATdv1VzjlBL9LQxSITwslBJB0cYN5NIp+i2OWOJ655nS47wLeQ
         Az9zAXkvRwM66AJHVUVrEKPoZpHV+See+8T19klzndFsPMiwdDZPJUMULxNHsXLH4eFK
         je0Ow4Y2a8h13HHagPBrHYBF3WscwttmA0Sws7ZfP4lgPb7mjk7RffAbH+y3kaAMzap4
         cMwH2BBOv9d8FEbYmKYk9mJti4E7SGFVBnwsZz69oZuVxLo/a+UKdh+IsRncbGznFJB/
         qoWh6RvZbJuB/5fTiXxe4lkP49GSPsXNcyCQHNBEgNXVBC0j0MmN8wklrEP/7HqNCtqC
         rV+w==
X-Forwarded-Encrypted: i=1; AJvYcCXq8+/BbDZ2ivtr1+EwM/KvBYOjQc3ZM9DXvEMFPQr00VZ+Tb9B9HmszJigFFUhIx465bMCD7tcUr4zEv2i@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhNtK/PnJ4V76HJcxAriW3N/H86qFtxvr3lZ7xfhlv5xGZNdA
	cpJ8yu4TrUfV93TYlKE8oOlnlqg4/FnZ6UpZ/HwlrusHJSC8zMxveXrEVQu73VW7UQ==
X-Gm-Gg: ASbGncuqAAeLKaZMPAgvLWKBq+drQ6WqrF6sMTKjXdv20fuojGvwrNIB0kbLRIrL9a+
	heY8djNGZ/0PRx5/aIDHXmk94k0Y09Mfnd+b1Q3DbP+qCPlGgjK2xc9o4wtRDonY8bRzHWFspIV
	+fUC7Fupi8oW+PPxdb+G0DDu1p1R+0vTOWzKA2d1Lu9t6KD4IcF/+gTefuRB1O2w9bPcjDZHp/p
	KqoKmBj6wvAj02OeSmm2qaXJVeIUWFjf2N1C3QkbDesxypuujabCo9ucjlWfb96QDixcdRgkqvV
	aF4CJT4qhitUwsPuik3CK3htyCS1uBG4J+nKhkj/mQf98Z9a5eDbuWbDOaE4/O9/CwSyzm9U21a
	Wk+K/jwJMDx99xqjmWaDBcDaJGi3EjEzKXTfJyvGXQMqqyq1+0XdFmk2FXCLZSI7QPr8LO+H2De
	j1tUkpY3t8GVXCJKs7kIkQDoSyPnuiEtb9rq0PdlZsXUBq9i0=
X-Google-Smtp-Source: AGHT+IH53ckBol+4yeTGTxnoskxcelqMTn+43AKcIW+arxac7wzKqrO4rD1ChIviUV6IKHO85b4pJw==
X-Received: by 2002:a17:902:f691:b0:295:68dd:4ebf with SMTP id d9443c01a7336-29b6c3e3c48mr197452115ad.16.1764095482759;
        Tue, 25 Nov 2025 10:31:22 -0800 (PST)
Received: from google.com (28.29.230.35.bc.googleusercontent.com. [35.230.29.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b26fff4sm176035005ad.68.2025.11.25.10.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 10:31:21 -0800 (PST)
Date: Tue, 25 Nov 2025 18:31:17 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	rppt@kernel.org, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v8 00/18] Live Update Orchestrator
Message-ID: <aSX19cWypvh1mKWM@google.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>

On 2025-11-25 11:58 AM, Pasha Tatashin wrote:
> 
> Pasha Tatashin (12):
>   liveupdate: luo_core: Live Update Orchestrato,
>   liveupdate: luo_core: integrate with KHO
>   kexec: call liveupdate_reboot() before kexec
>   liveupdate: luo_session: add sessions support
>   liveupdate: luo_core: add user interface
>   liveupdate: luo_file: implement file systems callbacks
>   liveupdate: luo_session: Add ioctls for file preservation
>   docs: add luo documentation
>   MAINTAINERS: add liveupdate entry
>   selftests/liveupdate: Add userspace API selftests
>   selftests/liveupdate: Add simple kexec-based selftest for LUO
>   selftests/liveupdate: Add kexec test for multiple and empty sessions
> 
> Pratyush Yadav (6):
>   mm: shmem: use SHMEM_F_* flags instead of VM_* flags
>   mm: shmem: allow freezing inode mapping
>   mm: shmem: export some functions to internal.h
>   liveupdate: luo_file: add private argument to store runtime state
>   mm: memfd_luo: allow preserving memfd
>   docs: add documentation for memfd preservation via LUO

I ran all the new selftests, including those that require kexec on an
Intel EMR server, and all tests passed.

Tested-by: David Matlack <dmatlack@google.com>

