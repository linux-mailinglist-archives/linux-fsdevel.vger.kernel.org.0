Return-Path: <linux-fsdevel+bounces-27823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4410C964562
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B7828875C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654C01ABEAD;
	Thu, 29 Aug 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MvUV5Avt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAA1A76CA
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935617; cv=none; b=T6awZPVMKmLdZqcA+pxFWSSmq8+/RnT6wS6LZNiNLyEJd25SURJbOUlWDvWWiT+T63uBoTeR7vzH71axUTG4DyGEaAAk4Vtr14KrFUfPmewc6eJ5wBUtX0NqUvutAA8K5yMwzkwWK9QzfFUg1MJEC2s3ubg81iaS8zh0OiYWBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935617; c=relaxed/simple;
	bh=igX6Wh4XlFExrXo//X5SQBXhZ/x7xczYlusp/hlvba0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzzQJH+Vaw8VjA/xBqkRQqBrgXQdz0YWgi/f3OYVJL8eoGQ0ml838AZo98ufbqRuIpzzmbvhvUZrO8ztOAPeVN6rHRavPnaoD+Qt4iFNxrjFquE4iPFFf6G7EriuJdBkCYBnh00n30clyM46dr6WEOF++CGzVFR6ankw9f/HPpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MvUV5Avt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c0ba23a5abso653966a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 05:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724935614; x=1725540414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=igX6Wh4XlFExrXo//X5SQBXhZ/x7xczYlusp/hlvba0=;
        b=MvUV5AvtTAme01GMxmQE5T/C+Nxmsavwr+ejDf9GrChD9iX5XtINmX1Fb2JS8zk4gx
         phZOiGgfiiYAJJHbpyzK+SM5B314rZuU/w7SpYDBvGZz+LlpbWfAw8TN/iCrELNx3CXO
         0ACwjphHf1+LfzoVIu8p54xSL/u7bEIA2jcrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935614; x=1725540414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igX6Wh4XlFExrXo//X5SQBXhZ/x7xczYlusp/hlvba0=;
        b=M+mQQGV6Y/K77iOQcidIW6hasxYJXiDrB4tb6u8AxuQYgDKjOEo2Xv4ZVaszjyuKaX
         F5xvp+kFT7IqVlmlblWKPgS4X/+b9Ii9ZT6/m67KEwxmoNK9XF3Go0PhuTaVQkAoi8Im
         d0KGKuKnnXdZ6KwltlD58MDuBPCmC/e7BiMrXdZtUtK7W58leMM5FLcuYH9VcXIbFNu8
         axRlSDdAup5PAcPj6qmtEkEifAeyxXz7S3ug43LNVpbdh/1KsfiHvr8otA8jOPHMaPvi
         QK15Wsc6vUH4wIiWsLMx/orikVZjzMDOeZJ1xIs4OPWiFOFeAla69XLnbjXW5JvbRlNY
         avmA==
X-Forwarded-Encrypted: i=1; AJvYcCXD/887THMBu3PcNO2rzT0dUjGlOxYsIccI5FPFvYaHkVM9hq9vuwlS7EYFYwDk0CWSJjoG8avWxEMtMAxR@vger.kernel.org
X-Gm-Message-State: AOJu0YyAXxFtYAE6KwIDhMMWX/PEqc7HNokJeUVQcsCvj9AqNfztFbq8
	TC98gVPVpKjkjO9LMRZeE6Sxc4o8rPbO21voq/UMf1FLyf6Wl/vQ9qTE7OSgkgqTKgVP/L23wj9
	acGchxJr+E4UP+cvAKiNO9azDiIKU2HWzBgrDeIVSQeYJk4iIUxw=
X-Google-Smtp-Source: AGHT+IFGZcKXXv8UPPEj6YYt3MsBrBoWmLP19Y9PoQwcaXWWQthx1swXsieyVu3f23Vm9EJ4JCwlPio4loTIgJrSetk=
X-Received: by 2002:a17:907:1c1b:b0:a86:8ec7:11b2 with SMTP id
 a640c23a62f3a-a897fad4f02mr214750466b.59.1724935613923; Thu, 29 Aug 2024
 05:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812161839.1961311-1-bschubert@ddn.com> <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
In-Reply-To: <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 14:46:42 +0200
Message-ID: <CAJfpegt1yY+mHWan6h_B20-i-pbmNSLEu7Fg_MsMo-cB_hFe_w@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: Allow page aligned writes
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Aug 2024 at 18:37, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
> Sorry, I had sent out the wrong/old patch file - it doesn't have one change
> (handling of already aligned buffers).
> Shall I sent v4? The correct version is below
>
> ---
>
> From: Bernd Schubert <bschubert@ddn.com>
> Date: Fri, 21 Jun 2024 11:51:23 +0200
> Subject: [PATCH v3] fuse: Allow page aligned writes
>
> Write IOs should be page aligned as fuse server
> might need to copy data to another buffer otherwise in
> order to fulfill network or device storage requirements.

Okay.

So why not align the buffer in userspace so the payload of the write
request lands on a page boundary?

Just the case that you have noted in the fuse_copy_align() function.

Thanks,
Miklos

