Return-Path: <linux-fsdevel+bounces-34788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D418F9C8B9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 14:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5591F249D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF11FAF1A;
	Thu, 14 Nov 2024 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qRx+3pYM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83178370
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590182; cv=none; b=ZW9wWcreafEzg01Ckx4u8ZSu8uBfoR+Ocy+EroZ7FnqDMKul5/k3Fv0zocbhciJunxwBUfjMwbSRA2KqJY/feC7+IuLqqiFRxM8nHK6qxqoHjJXSW6eMOVLiqNWOBEf7iBXaErhTm7dEA2VeW1lfvgY6yyeHrRsvzbkFVzeDnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590182; c=relaxed/simple;
	bh=eH26dx8KLUCKW3OLtuzDQy6K2ox77weOoauZXDs0gIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNBnOtXjP+loyITZt+sdskGoXaXhVBCwnjpf6g2SIn1BkjktEJbmaA5ge5Om7C0cxPPhvUBknZ6qiFS2BkUDFU729fFHptO3ndcn7IKHGFJ8OYfCAWKXHL8mEDMaO1j+4pItOg3qwY7+OIsu1/DyvteCxteF/rSjvjtvyYGv2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qRx+3pYM; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ee763f9779so276319eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 05:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731590177; x=1732194977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eH26dx8KLUCKW3OLtuzDQy6K2ox77weOoauZXDs0gIA=;
        b=qRx+3pYMb/6Nz3ApTXHSG2pqPnnr+tnjuTbmAW99f61xAj8YZ5T6f/f1Z/LLb2G5VE
         oWe+V5Gp1j1dBEDl0A2Z3NQtwQCE3Nf7kli9tzCE1WhYtFOLLn0tcgXBrbTXMJvJqwdI
         hwXG63tdk845Zus1oIgh7AqDV9odOMswGYoNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731590177; x=1732194977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eH26dx8KLUCKW3OLtuzDQy6K2ox77weOoauZXDs0gIA=;
        b=QykKEH+OprF3Vb2JIvj56TYTnqnxAfXsSvO5KYno/YxbQx7lb5PaYxCGyLdKz1IrYi
         P34pGTYB7aeXwnZUXyJjZnbDA0Dv74Zze3TPIVxIF7gN3nBHIC9lAv9M5CDOP0sz1mmb
         mCtZcfQ8Zf8ig+43UqJCy5HUcN+yJxOVi2Uhikf0G47NzzRopBt+cVavpN4sMxn5W1OQ
         Xrv3K7D8V9EZ9+OWAZHvkI1gdXl8+KXlzPkoqFQhjhGxMsk+r3bqvM8QoykwYKxh0ECm
         sFGmDz7soJzEoI+tqPkQt7H5IquqzW+T8oxGxBHfTE5MTjBHQUDS+YLt6LxWCMsesu04
         Y32w==
X-Forwarded-Encrypted: i=1; AJvYcCXc5JzEfCn/DdH0aAFKfE0n7aAKD6URaZJIEdEs6wYdiugEbihxlJnoHCF6vZTMh6uaijHB1K/HeKYLhnv1@vger.kernel.org
X-Gm-Message-State: AOJu0YxrdlJe+E/zOYAqe/NNaPtiE/yyyjcW5YRZlbfGT1t1LWlFsVtd
	8zESZ0nFupbJcqUUoDJx1oib7FAYbwJhPJ7IXhJvpAyRIraJVbCj+AMA3P5wJ8QjXJQopOmWvZQ
	3T286iImAEO4OlatpQ/2ESiq+IOX77ZF+jdQcxA==
X-Google-Smtp-Source: AGHT+IGOh7o2rK8Z7Xq3ismcY3/JzUtU+Mh/52llN668SNCDj3rlUfRC5K20zJzmxPpR4TWcURWseOJKG15ZWHkwsKc=
X-Received: by 2002:a05:6358:9791:b0:1c3:2411:588f with SMTP id
 e5c5f4694b2df-1c641ea72e5mr1261388955d.9.1731590177471; Thu, 14 Nov 2024
 05:16:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner> <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
 <20241114-umzog-garage-b1c1bb8b80f2@brauner> <3e6454f8a6b9176e9e1f98523be35f8eb6457eba.camel@kernel.org>
In-Reply-To: <3e6454f8a6b9176e9e1f98523be35f8eb6457eba.camel@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Nov 2024 14:16:05 +0100
Message-ID: <CAJfpegtZ6hiars5+JHCr6TEj=TgFFpFbk_TVM_b=YNpbLG0=ig@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and sb_source
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 13:29, Jeff Layton <jlayton@kernel.org> wrote:

> Ordinarily, I might agree, but we're now growing a new mount option
> field that has them separated by NULs. Will we need two extra fields
> for this? One comma-separated, and one NUL separated?
>
> /proc/#/mountinfo and mounts prepend these to the output of
> ->show_options, so the simple solution would be to just prepend those
> there instead of adding a new field. FWIW, only SELinux has any extra
> mount options to show here.

Compromise: tack them onto the end of the comma separated list, but
add a new field for the nul separated security options.

I think this would be logical, since the comma separated list is more
useful for having a /proc/$$/mountinfo compatible string than for
actually interpreting what's in there.

Thanks,
Miklos

