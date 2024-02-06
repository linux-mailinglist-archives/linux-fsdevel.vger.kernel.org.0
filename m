Return-Path: <linux-fsdevel+bounces-10488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E16584B89C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9C028A99F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364ED1350D2;
	Tue,  6 Feb 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDQKX9Ia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB313329A;
	Tue,  6 Feb 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231347; cv=none; b=Ur1Tgzq/d513fE+UwaYy+gzALKpsORmLg9cl5yCNxXXR8YB8xg576HgQmoF497/B+ux/RSsNkuJaNciH4luiYyPg4UVp/xKjm4DzMp5TS901v0US34vfpQI6xnX6gx2G3kJUD1bzt5bKvb9ac2SVVJYVbkIG55iaKn9rnJf6qLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231347; c=relaxed/simple;
	bh=P+XZ9mIc4ZZ7nNbi2oJblEjps9kTAmyVg/UPtun3xME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=PNq2JqQyzxHmw+OnUkXLQTwt8rK5Bxv+kwZ+qSv8BP8zOKSfDp6RWWYu8duUxf27VNLPwvDgsG7jBYin079XDR+5xhejHdFroQ7D7A3DMDYDtEG2iji06XcgKb5fOHAVqv1rjmxBg1JcsHZO0iODRIBMYv2oEAp4mYsS0bD2nZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDQKX9Ia; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so38580675e9.1;
        Tue, 06 Feb 2024 06:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707231344; x=1707836144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+XZ9mIc4ZZ7nNbi2oJblEjps9kTAmyVg/UPtun3xME=;
        b=mDQKX9IaOLI3CS0i+I+hPPHGdT8C4zP9WcwnDhTehso1RztqZM8A0++BrzmAxI0Hb2
         vwrsuppbQ+m3oyAZMEoAUfJEtPHuN1v2K3f5j2SfVTJUVExM15UOY6hjmXZgWFIRMorI
         W+eXzyH/Oo30oJnPY7oh7VLdRpp8fa3dN4+IGfF44LZL6pcZ904o2p2NkqLDD3yBUw3M
         4UAIjr+PLFy5yPW9K7F+WqenMk6t9ghqoqn3UjAsIgGKNvMu960xpvEBf+QUUW6QGgk/
         oDqkOeYU1XmSVYnx/WI9ZsihHPjVMhi5jaErKkUinCS7w2NDl8pOCQQyDW6tL0A041AZ
         XTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231344; x=1707836144;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P+XZ9mIc4ZZ7nNbi2oJblEjps9kTAmyVg/UPtun3xME=;
        b=E+64AIyRhrlVf9La+iICwQNM1NSCdl+VHBbZMel49HCcjGnWf5jtvMYF6ArUle8Km8
         cgsTTUMEPp35MEMv9Asxsct06WCCXnH5dKvBYdEYMK/nSY8EfG4jc/sW5RdRnplQX4PX
         4Itqu9ubC9dfQ1mwIHvbAJSAGCLYhU4ouMTUXuDOj9s3wOwfz/+ysF5WwJ7ueTsmiaOp
         KDLTICi2BAsYDEjb3LNd4YV18YJi0vJYCRSeQQFEryvdHOm5YV79vZLrEfYAM1t5XWSW
         aoLWIOPywjmKtzu2vxMhNGIPcEHxdpFPJVXC4OJdV7pP5jXlMwhxK00MHbAKNDvoNgtt
         IrXg==
X-Gm-Message-State: AOJu0YwKZgoKGWxw+cCZ7W+7F2H0jEaIl3glsiaLjHLoHg7HGFo6c3b1
	g+AuJ+G+S3DLzUV4mCYWgv1G0EJzSZdUm4Wu9OP1rRAUZp3vjPY2
X-Google-Smtp-Source: AGHT+IGCu12mB9a0AFI2Ba4BEGYbcnCAFKhgWjEm1Z6uIPmbfR8ErP1f3Wsb1RcCeZiIJSqC7deq0Q==
X-Received: by 2002:a05:600c:5103:b0:40f:c404:e2d1 with SMTP id o3-20020a05600c510300b0040fc404e2d1mr2172197wms.19.1707231344009;
        Tue, 06 Feb 2024 06:55:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWDK15ZzhPti6e+UKpuCLJ+9JFukOTN01W7k15JR3hJm0baSA7FuPj5PJJ3k4HijcEs5Rv0wkhg+3dhva9MPI9JBcXSvUh2zGRNkxVUjgrk0xotEExnIcaBAoYEUHedDS7Sj3CBwlQMCSasEXqn/y6c1pi15Mtxg5/H93/BGjq9uZAO+aW4rgTE7/JxqCootj4DK8Xsq0UsbUFzAh5te8GZotbsqIPtBeM4ONElJifzGw5pPzF8W1/0jxjdbI6jr1VMnqxR80uFjbYtSDRUushRf/+IX8nPWjF5oFWeSVJyMEw6Tt28Csojv1TsQSNLLbPRra+Fp0p729HNQehp/42CpldfO/HExuvqCTbk8X6f/xkCNNZqHhoGihKYVbQ9r//MK6U2gRWPS+6fWfcIo0tmPLmqBXNkW6/lD06BsD7LjSvEquthW8fQsyTBP5HNVBXLVtfmMjgGUTNhJR410OK83eQpJQObg01nURN3rFIK2qECUsVfA9RMzfNM3u++TxUi+3tZE40RwjVydmB1W8nZE8h/U5EChHJk+NKxwaG+J12i0hzjqDBrg+WCfRAH8yw09wHbFWOWvYiPtWEWTGQVKE2XADgkGoZPWJlP7H8Ii5AK55s56WLiWJ0zuuVOGQw8Jb8kgjrwo3htwsLesUC2/Y35SFyrCRLKIUmf033M1/a1CozvepAxGqjRGSUb9Xo2MO1lVmooDGgotT9fNJaL+RMINwks9cI/mihrgjCUSyg2Jv2r
Received: from ?IPv6:2a01:4b00:d307:1000:f1d3:eb5e:11f4:a7d9? ([2a01:4b00:d307:1000:f1d3:eb5e:11f4:a7d9])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b0040fd3121c4asm2243641wmb.46.2024.02.06.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:55:43 -0800 (PST)
Message-ID: <888072e30cc003dbed3f41675242b877246e2f0a.camel@gmail.com>
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
From: Luca Boccassi <luca.boccassi@gmail.com>
To: jgowans@amazon.com
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com,
 brauner@kernel.org,  dwmw@amazon.co.uk, ebiederm@xmission.com,
 graf@amazon.com, iommu@lists.linux.dev,  joro@8bytes.org,
 jschoenh@amazon.de, kexec@lists.infradead.org,  kvm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, madvenka@linux.microsoft.com, pbonzini@redhat.com, 
 seanjc@google.com, skinsburskii@linux.microsoft.com,
 steven.sistare@oracle.com,  usama.arif@bytedance.com,
 viro@zeniv.linux.org.uk, will@kernel.org,  yuleixzhang@tencent.com
Date: Tue, 06 Feb 2024 14:55:42 +0000
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


> Also, the question of a hard separation between
> persistent memory and ephemeral memory, compared to allowing
> arbitrary pages to
> be persisted. Pkernfs does it via a hard separation defined at boot
> time, other
> approaches could make the carving out of persistent pages dynamic.

Speaking from experience here - in Azure (Boost) we have been using
hard-carved out memory areas (DAX devices with ranges configured via
DTB) for persisting state across kexec for ~5 years or so. In a
nutshell: don't, it's a mistake.

It's a constant and consistence source of problems, headaches, issues
and workarounds piled upon workarounds, held together with duct tape
and prayers. It's just not flexible enough for any modern system. For
example, unless _all_ the machines are ridicolously overprovisioned in
terms of memory capacity (and guaranteed to remain so, forever), you
end up wasting enormous amounts of memory.

In Azure we are very much interested in a nice, well-abstracted, first-
class replacement for that setup that allows persisting data across
kexec, and in systemd userspace we'd very much want to use it as well,
but it really, really needs to be dynamic, and avoid the pitfall of
hard-configured carved out chunk.

--=20
Kind regards,
Luca Boccassi

