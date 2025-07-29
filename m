Return-Path: <linux-fsdevel+bounces-56237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F91B14A4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 10:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC75C1AA03A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB863285417;
	Tue, 29 Jul 2025 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hK6XMZsH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C95284B57
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778409; cv=none; b=fcGND00Pp/vp+p2eKQskvSx8XrmR9CqE+TpDYxbrVT7INNPkW+dYXgYPPUXo33NWDNt3hj3jFQfiSY8bRiesYBo+11P9MMtutUUcSL/ppPM6P/iw7G7DavFXdonv3w9eqRmqAF/mKVyY7TFbcPeJySkhF1wOYLPKwRIx4yEaAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778409; c=relaxed/simple;
	bh=uoz7ZkMcJQihlXVR0BYuvVm5pG5ejigHZYyAWdFYZd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTs9ghEQE2gwlHWoqQYNx37LJzv7Mn+2T6HyLSrXyMUywjE+v/3kQeras7TmLnJgwC3qLextLaSdcZdQH/Go1kZMdAg0YdrqbVyW/VyT7cQfRHzW8S6ys15v3EerDQCtQvSvNuwm5xmpHo70HoInewYSEYov55Jq8sWHZDzzAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hK6XMZsH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso9433408a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753778405; x=1754383205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VEdUxaOYlkg5cSBRz/WIlFpn0QDWtHgN/FibMeZhMLM=;
        b=hK6XMZsHr2J3tFvfIRhB2ah5ZBwlvH1HDmYNT8X7LaR98clPJhIJs20yUAQmASh1ru
         qQPUspa0rPVpMmCVUkYnvPywredaFD7gTSa39fQohxGdfjto3C89tfnS6PaZq9a7gPB1
         IsRh+GaVT+nuRkekKm+qEv8NID3CTJMIbQFc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753778405; x=1754383205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEdUxaOYlkg5cSBRz/WIlFpn0QDWtHgN/FibMeZhMLM=;
        b=g2OmAJOc9oqBvNOhtcn17k9TSZmeMEyiNKQ5GcmNTa8s/cg//buqVes/pgcqJMcWpa
         TytzksoyvyjidMFznuWpIHGn6l7MVYIgAF6nDYZSgv1VFNCRXSHyy/IMOUzPNsFKL80z
         JSgRCXUOVrvlsEW0C1JgttGyNXGdUqs/F4WM5DOq4cJCol7LXplyEoiyJgn4nV77Cii5
         BErqVA4KgEA29dAzz9xg6CkDaf+IKT95xVTnyJt+GDJjkhA4Iw1TOZerIVL+ooUcU1Nz
         MN4gwlqOuvLUWzo/l8bykYfgsPwVC6ARzCZvZqDWaD7aGTkJ82+4u6znG9jf9PmjG1zc
         r74Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKvKbURgFx5f2HXVcIdMzFv4EzOnKSkrFMo1O334Joq0rILKaFNYjTwb3tL9xqSebA/ZSD2TtH5U45u/aE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9g38MknWw9zRMWjLuoA+B/O9OkBTTqv5AF/OAj7IwqyIDXeW0
	dpdXyBtRJ+gBMDirfOaj4jVbd3YmAQ/E/q9QNAvYXbSVYMZV2I3vqvwzWnfS/UXtpldjBIpj+Gt
	kiSpOJgM=
X-Gm-Gg: ASbGncuYQw585JFGoN2loZT89iiLpd2yvmf2I9UdcgUJxjba3mxZntd+KP+pBNSUV8F
	3QYmUH7tAKBc/nB+yBfF53EnVpSx8DIwfZteOq9NceqvT9XP6UFezIIpEkPfg2H+rhicWqtFetO
	SIXD9wxhdRUcMHxFMcaIrCsJmdMx1ToKPWMlFT/1SePRHoezLyAu5SPt1/YTcfjQDeq4q/bXtHR
	19BKOS1bkIeqyCiAoYgPDlXGEue7hnJUWJp7umSCzNf3xk5HFUh+8sWT1rHEfk4oJTf+dsZiNTV
	WKj8b7ZTewcr7bgEbGtJpCOE1fFBm8G6xbUdX+MPeaCpqZxy0nZRjPJR7MzF68EtJmHG7+ZTV6E
	JoYqnmRWIY0P105/MSwokDHFOcP2CMNCvTxbFea3n30pczpyQdoP1yCwTa/dAkiQvGBxPJFs3
X-Google-Smtp-Source: AGHT+IGX1i9pVsbdWkXOhSSkhxHzPgl7lde3HSnXt1iqOqYLEiFY0ciqp/syN0t1HWEdZjh3CGelfA==
X-Received: by 2002:a05:6402:2106:b0:615:10da:1c68 with SMTP id 4fb4d7f45d1cf-61510da22b3mr10723164a12.34.1753778405029;
        Tue, 29 Jul 2025 01:40:05 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500491d12sm4345062a12.11.2025.07.29.01.40.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 01:40:03 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6157c81ff9eso53862a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 01:40:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV75RgJsjch4hPFY5p9JtlGIMkJzYp6PKlGpQoCw+OPnGCD89F/RIzuBF0ElLuGIz8OB8cw7GDlvcZb6c3e@vger.kernel.org
X-Received: by 2002:a05:6402:254f:b0:608:8204:c600 with SMTP id
 4fb4d7f45d1cf-614f1bdda7fmr15234556a12.3.1753778403272; Tue, 29 Jul 2025
 01:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-integrity-d16cb92bb424@brauner>
 <0f40571c-11a2-50f0-1eba-78ab9d52e455@google.com> <CAHk-=wg2-ShOw7JO2XJ6_SKg5Q0AWYBtxkVzq6oPnodhF9w4=A@mail.gmail.com>
 <aIh9CSzK6Dl1mAfb@infradead.org>
In-Reply-To: <aIh9CSzK6Dl1mAfb@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 Jul 2025 01:39:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2KaNHTs-gUa227ssG-pE8NMsaz3bg=asx--ntVJaqJg@mail.gmail.com>
X-Gm-Features: Ac12FXxiou34yJ26O5gObjzUmNr77eJrMpDAem_rcuw0KJfYqhOYZO_2ZZE5Eak
Message-ID: <CAHk-=wh2KaNHTs-gUa227ssG-pE8NMsaz3bg=asx--ntVJaqJg@mail.gmail.com>
Subject: Re: [GIT PULL 11/14 for v6.17] vfs integrity
To: Christoph Hellwig <hch@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>, 
	Klara Modin <klarasmodin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Anuj Gupta <anuj20.g@samsung.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 00:49, Christoph Hellwig <hch@infradead.org> wrote:
>
> I don't think overrides are intentional here.  The problem is that
> Christian asked for the flexible size growing decoding here, which
> makes it impossible to use the simple and proven ioctl dispatch by
> just using another case statement in the switch.

Right. Which is why I put it in the default: branch.

IOW, just handle the important real and normal cases first - the ones
that *can* be handled with simple switch statements.

So putting it at the *top*, and then saying "if it returns this
special error code that isn't standardized we do the normal ones" is
wrong.

It's wrong because we literally have over half a century of confusion
about error codes in this area, predating Linux.

And it's also wrong because that new ioctl simply shouldn't be
prioritized over existing ones.

So I'm just saying "don't do that then".

               Linus

