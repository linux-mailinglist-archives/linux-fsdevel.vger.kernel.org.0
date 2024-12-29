Return-Path: <linux-fsdevel+bounces-38244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE29FE007
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 18:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914B01882CDD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADAC198A17;
	Sun, 29 Dec 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U2nstQEU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9022594BE
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735493264; cv=none; b=Ya/au0hah7NNQA7QuEipQRjwlL2IygCJ58iUEMBXuqaWnP6I2DAP9ngwj9wfzVp1pCfU/dG2wbGEzSNGSIJ3nsbSJgnhI4vg3ZbgYStpXEgE2iQFS4n0HzkOOxWl4e4zCXp36qf+aBGJiOqNqGcaNsdlootEqcudfJP/6Tp+42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735493264; c=relaxed/simple;
	bh=TQCmeWZCzx8OQcaYNBj9qyqDdkeYNXixteTnMps/iyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ex+W7gvCvR4fixirj3E4JYV8UoOFkRi1ft/el607pcy0FeTw6U6lxcK2+DpzFZmImbnd5DO8UtYUQf3PPHa6hDVN4Di65B6WxX4WdZb5zA2ycPO0J1dUNSHoevoZFkJzciZFVYYjzKK5neVul1PbHV5g0A7gK/7xDSR/oMvHTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U2nstQEU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso1189373566b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 09:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735493260; x=1736098060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7a1vZAQNi/4lhbmtM5PrN6TtAvwGa1nioKtjBipxI/g=;
        b=U2nstQEUqtLK+jX9zn4EsgIp2sDEtFHt2VP+q6rgb0tQazDW4/2WxI9XcxhFlKIKO1
         MqacSTguO+F2lCSK3veXcQ/eNMCTL9UlGDDR+W4izKiv0PlJN4LJ9Dvqk5Z+iDeSKMOu
         7L4RCB4t/c+GNhCal5n017co781gV3IJZJcz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735493260; x=1736098060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7a1vZAQNi/4lhbmtM5PrN6TtAvwGa1nioKtjBipxI/g=;
        b=fqL1xaEAbzuaSoEqsG51ufI/1fggZvz81inKlc93Hplw4ncPqvgm4zo2D+OeLeGI4C
         cLCUnuugN49/ucriQfj7NLKTZPVNYldiE5mdmRQd7gZrEjkFe6SkJFDrkVbxcZQPDLJP
         l+Yxa/exuZdbhy/kKwzKjCrMUUIfqzfnwQkE6E3wn8sCs3RfihdBJL82uidaAPVFcM3X
         eCFAnwsX5KSXj4n7rDgUabfbOe4McYB6Q+VRKE8jvTWnSnV8FO097mswgC3j1QOEG1Lj
         S7K477RxSKgRsnSLzW++lbMnpAfhwk9CwZzDwD22cK1qKg8tPuF9/CjSUP6sfgE3dbSB
         phvw==
X-Forwarded-Encrypted: i=1; AJvYcCV/i++qQI2unOWpCB/+7yp+dxQO3DwYD7mCpjsxZlbZPaiicTnyhkDHJw1ANC9ucacePeSsKRvBymfbU++k@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5dWDzVSQKYPAZvfZILHjzIZovmc0IFeCor/wM+js3UwKGmzR
	AoNMvcwnjVahd0EpuXlXUHJwNcfmPIHA9+kjT33wMPn+NRe0oMCApXFBBHWcxxT1V6LEnYRJ2nA
	xRuU=
X-Gm-Gg: ASbGnctFUnrzPK3RDP5o2sdXkUDIR6otk7VB+ECi2aPn1lGqGupKAZSPCM7cBcpmFpO
	NZTZ3y3kWvMha2z1o92m5FcdD4FPb2pQ4ZmLyawEYYIr4UC2JUy7gOLOOA8uWjt23U3MNYkTWc3
	KDSyYeIFg+3KZWG3s6T/5UjB95bx9FfnzSWnhQSzz9zhQHMksk5XBPvBU9a/8npsd+sPWvMleF7
	Ka8fAGd/JmsFe0z+3xjeaX4vDQanGasPAwgJvQ9fMPlIjUF40MGEF80VH4o9yere8ENZEUzmuKS
	uEZXfKF+6MzmGK9wCVjHT9Xk6zLHvPM=
X-Google-Smtp-Source: AGHT+IG8M6TeFBnN1qPwmi59aEX+zvNcAZwtXNJMyrkaSa/x60NfXNcJq9ZzCJt6aho2N62tlHozFQ==
X-Received: by 2002:a05:6402:5297:b0:5d2:7270:6128 with SMTP id 4fb4d7f45d1cf-5d81de06427mr76421507a12.25.1735493260114;
        Sun, 29 Dec 2024 09:27:40 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f26dsm14109556a12.20.2024.12.29.09.27.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2024 09:27:39 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso1189371566b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 09:27:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPYn46BBcmnOw1CvRQP/oWQ6c4oCTiIaXiXavZbxwbt21VF/4Itt0TMiQWLddPCYVkom6IVMkC90yiKRGo@vger.kernel.org
X-Received: by 2002:a05:6402:2802:b0:5d3:cff5:635e with SMTP id
 4fb4d7f45d1cf-5d81de065b8mr77626276a12.26.1735493257885; Sun, 29 Dec 2024
 09:27:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241229135737.GA3293@redhat.com>
In-Reply-To: <20241229135737.GA3293@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Dec 2024 09:27:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=whZHXHtpdakcLx+K-LF0=tav6r698Ph3=p3Fpuvi2D+5w@mail.gmail.com>
Message-ID: <CAHk-=whZHXHtpdakcLx+K-LF0=tav6r698Ph3=p3Fpuvi2D+5w@mail.gmail.com>
Subject: Re: PATCH? avoid the unnecessary wakeups in pipe_read()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Dec 2024 at 05:58, Oleg Nesterov <oleg@redhat.com> wrote:
>
> If I read this code correctly, in this case the child will wakeup the parent
> 4095 times for no reason, pipe_writable() == !pipe_pull() will still be true
> until the last read(fd[0], &c, 1) does

Ack, that patch looks sane to me.

Only wake writer if we actually released a pipe slot, and it was full
before we did so.

Makes sense.

                Linus

