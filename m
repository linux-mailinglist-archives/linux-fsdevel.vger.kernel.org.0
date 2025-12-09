Return-Path: <linux-fsdevel+bounces-71004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20067CAF205
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 08:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED76305F7FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 07:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57365287246;
	Tue,  9 Dec 2025 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bLwkTlHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCE0279355
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265183; cv=none; b=BLUPKkKBYlY1ulVFdnDZEm8NiubDP3yg8L38YYk2dy9+CO5bu42Pz/lco6Fod5cM/Vb+lvd/VpjdZi99pqxtl+Zcipb8F9QchlVIzYzIKBB+ZyxPOxRUq97RZFuLCuo5xlUyRyChNnZZh7VW/TM8hLDX0dtgjVV0CiTfCxjYuj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265183; c=relaxed/simple;
	bh=8nT8939qWUoJYlT2R7sKtRouAfpezWZVT5T0CEHq2FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pbv+xXPOqRCGI0N8cmViKVX8X+Vq1TgltkvjHNLSMQwj6oas231NxN+86ahf2PutOWT8oTqGofzI+nj6POdxRz2qHb9a6scdwHab4WqJHBOSTihyjAx/QsZX9K/z6e4AA2g2E8CbT/11ZBIdQUnXZcCQzy7zsOQhC7G12gPHcuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bLwkTlHc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64951939e1eso1881425a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 23:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765265180; x=1765869980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7QhMUSo0zLDlINi8GAqDQeQHdxTHsyz1r33NHLku5hM=;
        b=bLwkTlHcWQMBb8tY5U8TY+BoyY1bQaAgjOvn5Pb2tufZIWtWZX1vMsOlhsRD46FJui
         EbvQVXbNFzRR01zBOazf07qk/Z4GMDHRTd4Hz3K3qCHL3jVQg0WJ+cJzrNwa0OumUK5Y
         FpFusuE/Nm/EUhL1IdkhusVg94AygieSmpSbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765265180; x=1765869980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QhMUSo0zLDlINi8GAqDQeQHdxTHsyz1r33NHLku5hM=;
        b=XsVTBuRcIXgAxOqTDPs955TEdvhP+6nNxr10WKeebpBmw0cB1jnYdnu9SJpjLgrjmq
         OeBqrxfzZSI7H9L12DmzNIkRjjUI3ICEAeh+vawREjTV79NYUoBQyc8wdAWyYDzy0w9Y
         QgJ4oTNtgJV0Lhm+8L6Ts1IGl7ceK8o/xmH7YIYENOyu5yf1btN50c6TSYTcoTpZm0Sc
         iU6jKUaY1BQhCHj4hPAcMT2mPo3U/cdBn2ORT+hRbBzhpUYwDu9SxjCeX+IGrju3L5Bv
         kQvhAh6UZ98n/ve2oZeK7beGJZ76ANHKA1NONltX35cdZTaTgpvJ24ZPudV4A7OR6n19
         0YEw==
X-Forwarded-Encrypted: i=1; AJvYcCXaLDNl5dMO5HM/SfvcARQ7Yh4/RlQEfv6tpeVqJHc28w7p8BfolBdc+key4jIQs/NbGxWYof/qTIsxTS09@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15l+XXPyMlsD9pA94J3Z3s4pehbXJ2ngV3li2lYTXwI9FlhYn
	EwBwOSSnw4NfFOnv976oklY0dmUw3KcB+yahis/JJlkkUQEvGmbefwfmtwWglzVx2zJLxycDErg
	xl2PBJK+Kow==
X-Gm-Gg: ASbGncsOM/C70rYyUGllBkuSX2js8nvqXUqvcwbreKSAjHi4ao84R3Gr0ZpqgSBPy0X
	Ilwr3Sx8u2ClPg2VhUnm7gdGmWmDMq8A8BtPu5Yt7zuZFKylHYdZ2BhQBdS1jH9PdS7sF3jJTPD
	V0S7nDctxtU0XFI2wUzrLpnTdbQXWDsoK36r1woa2gqG0E/wB39/iVaXSJPQoLvpi904jJQpexo
	TNnRcVeBcvoq9lumg/wCXcVXtWdy22GOimGjwaoykEF4AJirEYXf3dKkJ3Gvde7PrpMnU9UyS/b
	y17CruQi+4VulH89QJpT7OY4DW8ee0NcSgQb/AqXni6wNvNX2lsAA02/n5uNG7h7Nd+TZLEWw1t
	Hdrb3rhWzTOiyMECqbxcPHptWunq6WsCVod1UWkAqPW16W9+MNwq8W18DhVwe7pmPcKb9BkpraJ
	GZzioAOGJeDOJ147gTbnsLHiDurD/qNW2YiWkql0drm9G6ilXvcHvdADkXA4jn
X-Google-Smtp-Source: AGHT+IEEgxo+cJO0HpQOzGjbDOCIVk/S/Rw+Yl/T7DaLesx6w6WcWRvlajA6GzMvAGpEBVliQF5KVg==
X-Received: by 2002:a05:6402:5248:b0:640:a50b:609 with SMTP id 4fb4d7f45d1cf-6491a42f7ecmr8666990a12.16.1765265180061;
        Mon, 08 Dec 2025 23:26:20 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2c5575fsm13385718a12.0.2025.12.08.23.26.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 23:26:18 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so7320580a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 23:26:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEUL/mCeAoS5gjhkPvG5RdI9oA0UG8w2iJew8xkf8oYxXXKeV84RRK3apJ3s+XAS9Ng06vsEGNAS5UhEt9@vger.kernel.org
X-Received: by 2002:a05:6402:350b:b0:643:883a:2668 with SMTP id
 4fb4d7f45d1cf-6491a430019mr7384754a12.21.1765265177527; Mon, 08 Dec 2025
 23:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com>
In-Reply-To: <20251208235528.3670800-1-hpa@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 16:26:00 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiNMD7tCkYvVQMs1=omU9=J=zw_ryvtZ+A-sNR7MN2iuw@mail.gmail.com>
X-Gm-Features: AQt7F2pU3mtSVlk8xXoOHi4ywQ2NpA8rkmyzrskk-X7c-Gbp__mUx8NnR72v7NM
Message-ID: <CAHk-=wiNMD7tCkYvVQMs1=omU9=J=zw_ryvtZ+A-sNR7MN2iuw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Dec 2025 at 08:57, H. Peter Anvin <hpa@zytor.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git
>
> for you to fetch changes up to branch auto-type-for-6.19

Oh, and as I was going to merge this, I noticed it's not signed.

Let's not break our perfect recent record of using proper signed tags.
when I know you have a pgp key and I even have it on my keyring.

Please?

              Linus

