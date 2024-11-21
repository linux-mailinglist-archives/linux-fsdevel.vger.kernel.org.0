Return-Path: <linux-fsdevel+bounces-35488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F429D5578
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 23:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8231F23E1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 22:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822031DA60B;
	Thu, 21 Nov 2024 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="A9DtDzlp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EEC1CEAB8
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228131; cv=none; b=E1R9URhtjkVzc1n8T9Idp6rk8UUmyV4JziffyRFGgl8x7ulYY9Gqx5m1PhvLcYFeJ6UJWyOMjXJfNfbTY/CuJtlzEHF6IrD9/X8Zgg/phjoEsT3ozDgb8DUdzz5t7gQxDe8Vo9nIdr57gTqenHwr+3pIyIE0WAJf5+1em2Jhz3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228131; c=relaxed/simple;
	bh=NM3V6zaMGS9FYctgok7suDRu8wkYahGK3/IfRztomJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALEbXvOMfePRQHCwHyFDxgKR3sHoJxAhJKjyzsdrWHr5Z+WxvVIUJcLXT2Q4x4qxBYZJuKfjGfKe4dCs4WorwQSqWGN5v/VtOIscd8bFtBIFIHQw8s5Uk8y1Tc8I9B2Fi1+rGN9i8aQcJS27GlvJBUh5kT/yD5cUcwwmocv9EOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=A9DtDzlp; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6eeb3741880so14653297b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 14:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732228129; x=1732832929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EoKEXnI4uTZ8zf3Qs5aeOGboVKmKizuhzfKbKzYElaw=;
        b=A9DtDzlpCcpUNuFCNhiXfte+0CMQisGwhX+B7yF2DAqSHItjlL3Z/IEB13Z/LZm09w
         IJ+zpVJnwoN9lW7vLptRdYes4UHkcTr8Xr9TY5G3XQ81dGIgougaMCA6KoLCReog9JjY
         59mdR08SQtMAYBX6KkQ6QF0PTqtcFXUYWyWp4P9aZjtf7EOErUbYoigh71WJ6I58ZKL8
         R2fwrdRQIGDhH3tbnAJlEG5Iiv07IbKdzaED74oOgJZAEjs+h06YJiFMPWBDn0R+AJoP
         9HCV8Q+UZlWMaZK0ALzYlue83223qa2cb4BeAWFtkz9WEbuVP687i9qIiO/rUb33Xh32
         5Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732228129; x=1732832929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoKEXnI4uTZ8zf3Qs5aeOGboVKmKizuhzfKbKzYElaw=;
        b=kZknElJaSIF/lM3LRXgQVZJJ5o/fgE7KlHaprZm7DJqWW+rb50oSU9t1eQ5G5rpdD+
         ZYmAXAGL0FQowOx1NB+pQILF7YVWqYfLl8t50WaFHXsGWXx6URc0zNtFj5vS9nhafFVo
         FV8jubyQvAly6rz7GTyIPh7ZDB11In2LqhcpqRoKvoq2JpMfdcqZyUCbm78HGAFzMPBE
         I2tiDpZWIpMZzOEKGDSPb1wkigAeJDP3rg+U6AQ5M6+iN+OKQ0t9971CheV3IweT86N+
         c/E02NHIO8FIjtGC6WXeXISxD54r+DwuM+X4Zc0qccm8lRaWvJMeAcPNXjn72M4IkryA
         lw9A==
X-Forwarded-Encrypted: i=1; AJvYcCXUQeNWu9HvQEnWVDL6gPEJqAVBe7aQtZSGyBjxhulmf6RsDOZOwsI/wbYMHlHQjyUj0b8pC5jkgabheL+o@vger.kernel.org
X-Gm-Message-State: AOJu0YxpB5aqK5rUzmhGeHfPKYHU8ReYg8f1nZFMndveYJGNj08wKd25
	9FWiySiv4tz4WkynznuAXwdaf99vgnFpU5yDHb2gwtXY8FilhbJ0YuMofDWG4ag=
X-Gm-Gg: ASbGncvRiRfGXFfp00fxgs8Pmo2rzAfheRsBZgRsiwn4lwyg1gNEfyDqQZHEB8gZtgk
	J3jsa9+5QLn1J87cv3cOmR5DhAtynG4EjKe04o3/n12mQ4nKEnDTf/xr9ftv0IJqTu3Y40kDaTZ
	bZgrsjCJUG4Pwnamou1BAose7YEIMNgkiag+7bxIOR3HZdwp5djybvWLJQ682RbLDOdi2wnV1lf
	j8prdhYo5lWRsgzOtK1I5+u74URWUL3HuIvJzygu/r8+ZUJsBo2C0nxunYIx93T5ZiWWpLeTk+u
	kOXb5IH1+qY=
X-Google-Smtp-Source: AGHT+IG0ZTj8DCitlmyMAoqVLydivdT8o1PTi6zzQUwvZgAuAxuAgyvDA4QDZQT7q4MMXMtULkXJsA==
X-Received: by 2002:a05:690c:6d0d:b0:6e3:351f:d757 with SMTP id 00721157ae682-6eee08b9226mr11978137b3.24.1732228129379;
        Thu, 21 Nov 2024 14:28:49 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe153b6sm1681957b3.27.2024.11.21.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:28:48 -0800 (PST)
Date: Thu, 21 Nov 2024 17:28:47 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 03/12] fuse: refactor fuse_fill_write_pages()
Message-ID: <20241121222847.GD1974911@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-4-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:49PM -0800, Joanne Koong wrote:
> Refactor the logic in fuse_fill_write_pages() for copying out write
> data. This will make the future change for supporting large folios for
> writes easier. No functional changes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

