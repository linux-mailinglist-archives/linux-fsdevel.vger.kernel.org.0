Return-Path: <linux-fsdevel+bounces-19258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880A8C2345
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC681F22437
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45CC16F82A;
	Fri, 10 May 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JpYLSKGO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750DB16DEDE
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340241; cv=none; b=UzbpopDh2UPiLNiSKJdoT2oIQCHf5mXPRoTlFxCy0URRELDVQSFlvMzgysA4e9qoAoh0DFUxAXvnIjMU7Nt7xgUuN11dm2S8nCvaLybbXgVl7OIudBiogOh0frG/gdcP+OYffdlyK1T1N/OWoJKSW0FKNqdp817/tgF7EZGcrcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340241; c=relaxed/simple;
	bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0DNZxR9g3K0qNq3ha8RY20E5mKCb0+q1nbU6llNDVskpFHEkPyftUmQCsotB5J5iwQ3q0SJjYnAHUjyEyE04WDqOjR7k34s1USxS3t5ZHxukwh6BjNLNRADkxl+zAosq42cyVquhreBwDQ9wNC3s2FXCoq3UTwCdzEE6CoLX8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JpYLSKGO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59ad344f7dso398639366b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715340237; x=1715945037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
        b=JpYLSKGOBfaIc5A8kOsi5/Dp2+/FW5QcD3PSDQjxzFhPoThcC9BFnBTZ6bjdLPn1y2
         H3Ciyfq/DoepN2m57HmuLeQcub49JESXoeDmgeJbyvwVncXszisdoYaiKihDJhidJ0fS
         guBqjTh2IcbqsTVlhlUJUWjpelIrxQkrhmoR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715340237; x=1715945037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
        b=AdiFL3LsXIoWV7vJbZ1HIZMm7y+SzkcU3QnRp3HUe8j87kZLZ5B2dsWneBdeH0irzH
         hcGxNIfLSqXqHiMq67cR3W8s44OtmtF8s7kv8HyRA2E+y4F0EHJQOsQqR1PsUeZCvlFi
         rJrOqy79YYZy2t1weHOb/Cy+vDxEgbZ0t2rScyOMSjPmeT1+MT5reNxXcZPurOd8OVyo
         iiB0UesSot/EzUymjMbI+lJhPj+UJAeFRiycSFeDkbyYyz4o7ZyTpFK4tCzLq82Gx24k
         KBpT5wAmh4lTnSV+YNhDFcG4WG/buM4VKqTY/7/0fP/LZfQKr2zfFiItfTgQ6/bA+cl0
         /7ig==
X-Forwarded-Encrypted: i=1; AJvYcCUoAGMsjsOZYycpHVcKLMn0ayHlzIfZihH0prP274azYDshqnt4eTjw7Fn4AcqDt4fLyZcvqzMMNIANLvfD0/TvMhCxwX3/MxtFPPfC/A==
X-Gm-Message-State: AOJu0YyMZu92NMS03yvLls0LxzfSMJGV6CGBt1HlZvLLbORtcvZDww/3
	cyLo3IvyJwa6ixqVzerF6PRJORaSBKKxMu1McWP+YKSqoLRHZFD88/SDBwZg15EQ5OZnjsnek5v
	4PagHXRM+9P1Z0HwlX3M+dRRtx5N5OMyrg3TxEA==
X-Google-Smtp-Source: AGHT+IFz5qP18mAylhBbmtThupMzDKv7Hxf/YKoxmcI8024bWwzwHlVosWJHVpjswkQo1H6JZ+uOIVvInsfVrUzL8aQ=
X-Received: by 2002:a17:907:26c9:b0:a59:ba2b:5913 with SMTP id
 a640c23a62f3a-a5a2d66b525mr199596766b.62.1715340236873; Fri, 10 May 2024
 04:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502212631.110175-1-thorsten.blum@toblux.com> <20240502212631.110175-3-thorsten.blum@toblux.com>
In-Reply-To: <20240502212631.110175-3-thorsten.blum@toblux.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 13:23:45 +0200
Message-ID: <CAJfpegsVWa-fu=DePSC0J1WkfQxhaqs0RTxopMBHduwMANieyQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] overlayfs: Remove duplicate included header
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 23:27, Thorsten Blum <thorsten.blum@toblux.com> wrote:
>
> Remove duplicate included header file linux/posix_acl.h
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Applied, thanks.

Miklos

