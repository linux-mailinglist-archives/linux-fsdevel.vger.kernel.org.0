Return-Path: <linux-fsdevel+bounces-51951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB68ADDAB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B3E17DA9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1867828506F;
	Tue, 17 Jun 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKf/KI6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D31AAA1B;
	Tue, 17 Jun 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181511; cv=none; b=NuztHYHqMYhMjALCdGWUWBTbfbCB71WJLvXtIyU938y+Pypu9N9bowM+oQSWAu0p00eyju8igyGOx3x3pJfZMS7nG0YeW9x0Sc8ZNLq7E/yKqyptsq5YxqUOElDqOKn3y1gUHbZeDYCUr8gAMuDHS9148b2iQEFFIfx2wCJKJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181511; c=relaxed/simple;
	bh=C1oteqzGtNV2dJNDM1UNICKeNKVQQ3W1UKuNpSvLFoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6T/lOMh3ZUjDi1ernVa+Nf3rxOgIoiYP5TbzwOCgnu8mJsZJa+yL20CI4lJAtD7H1o4LEDIse0zBhj4h7ZGddO3w+nEftIBIWElaH35YqXMW2/bFCgZ4BYKiR77iC8S5UewhCmsg+i7b3p4bmsSLNPimyXySUGxohwmdyi+K+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKf/KI6X; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a589d99963so779139f8f.1;
        Tue, 17 Jun 2025 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750181508; x=1750786308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1oteqzGtNV2dJNDM1UNICKeNKVQQ3W1UKuNpSvLFoE=;
        b=XKf/KI6XHKumb5oPItS1Df9p2Xw4seCVksbxOxnxHqbTAJoSCq0Bngb2nSbSOm+vza
         O7tu23OK/MrdSVUZ3glSI+XGnGhuS+39KSCdh7LkKSr6Csp0BP3q2X8mZTws9Bfar/7C
         8JQThs9NPBMnaKGLWypvlxRR59sHvNCzC/th6SnDMvTK6oeOsBDGSe8brD0rWP8fdepB
         Z0qgUQcxFbopl6n6CvFmIvyWo1LYCbNk/ZW6NEv0Vba9rsa0RSpAyBTyAjYltmWe1j+f
         aYaM/nnscRHzVK6PIn7QPmmRQj0fleCnc37MTPlC8fqm5asqF3l/D2obbL9UNWhpSOgm
         C1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750181508; x=1750786308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1oteqzGtNV2dJNDM1UNICKeNKVQQ3W1UKuNpSvLFoE=;
        b=VRLPawh8K6En4iceuODDQHzQKY/SF0QT/+RsyKcly3YUC7ZOiq76qiWZMjcnFYM4p1
         EVSL4IATpSRzV4NNBtn3VXR8hfVUjxdyTpUJEBjN57vfUxJBqK//otKLAJUJPHZJwQEt
         /agxLoOzmdRlmrg+bcrE/XeV/bXAKHTT96yM6KtL5uKKc3sTtpFg2ZNyBIzee7QHPnnr
         fQGFcmZbAfWwrtXZpBXax+tWbL8BZPAiRHinUVaHs/xjAse+mMKF0JX7aC8cfUS7ZyKD
         NRZrPIYXe73HdIUtyz9Jez8Gra2dDyK6iaNSUVjr8IDIsMTRZ/rYGj6kWnFTw9L66WUE
         n5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVRR1KnGhiilrOAb9S04F04Zf0lzkSs3EmLJdZjlNDRnYAE8DDnfkE1gykg2wFe0l7BKko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8U+gljGLXYkmJBdIF/1XMh6I92GPn043y+KJjxtfX5d0mUgz
	0H5rgx7NQVGsL36D0i4t5OWbVRjS+eZgHOCqZm5Z+55hfDvKeAGDMWMz8CYod4LPSnr519+Dwd8
	nWluY1frgdkV+h5DUqk6n9KkdjIH1nKJZOw==
X-Gm-Gg: ASbGncvoAAx6yq7JBxZHy0iwMrF/fsOAgq4j5uRzr0paIzn3hyPz8TxfwnbQRkALsCB
	v4/gAohYphJpsr9baGcVWZbe3m4BP+VxiwoBxfxtKbr6raRfe3Ih6pE5ik8CFY0EMHcgpYMf/TA
	pUwIkx50VBZNwq4ADtptvLvCqJzD89FHRxmLB5dnDKCu7wc9t9h9WOtDTE7wU=
X-Google-Smtp-Source: AGHT+IEX8SqGhGeQNiWWZhXZmcotVKep+BxfEa1OkelpnqvLVK6AlLIZX+5wcsS1ShVnckJLqjB7Bwoi7T42P5dfYUI=
X-Received: by 2002:a5d:588a:0:b0:3a3:5f36:33ee with SMTP id
 ffacd0b85a97d-3a5723a3abamr11091434f8f.32.1750181508147; Tue, 17 Jun 2025
 10:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615003011.GD1880847@ZenIV> <20250615003110.GA3011112@ZenIV>
 <20250615003216.GB3011112@ZenIV> <20250615003321.GC3011112@ZenIV>
 <20250615003507.GD3011112@ZenIV> <20250615004719.GE3011112@ZenIV>
In-Reply-To: <20250615004719.GE3011112@ZenIV>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Jun 2025 10:31:37 -0700
X-Gm-Features: Ac12FXzvw-lbBncgcC6GRGMvg2Y9OJVeYFYxeL5rKkWFwPKXYFUjvGPg_ym0-kc
Message-ID: <CAADnVQLB3viNyMzndwZbfZrpwLNAMcVE+ffwWPqEt5YVa3QaVA@mail.gmail.com>
Subject: Re: [bpf_iter] get rid of redundant 3rd argument of prepare_seq_file()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 5:47=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
> always equal to __get_seq_info(2nd argument)

We'll take it through bpf-next,
but it needs a proper commit log that explains the motivation.
Just to clean up the code a bit ?
or something else?

