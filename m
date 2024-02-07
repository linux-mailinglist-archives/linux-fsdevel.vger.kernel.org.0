Return-Path: <linux-fsdevel+bounces-10599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE0484C98C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 12:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBADA1C25D43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53F81B295;
	Wed,  7 Feb 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jr5HHEPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E41AACC
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305037; cv=none; b=Q+zRAvwNL/dcQ3pOc8UashzTybT+1HVkrjwwLX00uXgdIm8/5WcgqPYPGvb4kBw1JmBuBcWzahY9D/F+x0wcTWGapmY4RUmQBBOsDYoM/CaInzkJnEL3e3q53Xq3qYND1NR0O20VL+KkTG/fOLNAfzjLCVjlDCU0F9hLqLdJyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305037; c=relaxed/simple;
	bh=EP2LWSy9JtM2+WifJPVQImTTMtI7Kx6N1OY0vOyamyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxY8h9FsoDMtxRPESaOBE/5eqKfup9vkFLQRx7j9tvvVTy7Nx/3awxZ0foW3o5os5+fdGuQz/BzQkQQ8jGL1Y5ad/S62+VtrLp/tMcl13GJoeFB20IEj7rOYXkquahYECB5ljfy2bdg9WqxngD0jddIofpg8WJaz+1bUKffvSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jr5HHEPQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56025fcaebaso611047a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 03:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707305033; x=1707909833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EP2LWSy9JtM2+WifJPVQImTTMtI7Kx6N1OY0vOyamyM=;
        b=jr5HHEPQLehSrT4xGvy7jTMaZ/rarUkeWIUEachlZY8LZ6OkTqKfgrkeGNORIT+b+S
         YzJi67Bui5i3brMIyi4NzdtSbxzoF9A2rY8NuY6LJsl9xOlfJF3nluAj912ydmSpJBNx
         X9xd+Rk/ksezH5ClOzoJEZW0wJyFsAzJHZwoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707305033; x=1707909833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EP2LWSy9JtM2+WifJPVQImTTMtI7Kx6N1OY0vOyamyM=;
        b=qBTorgrkhan13eSfp5t4ZzVoihVNyU7rWYGLkzhh4QmqmGs9/l9o/CKp8mjDsYSvwP
         Hzyy8DWBbl6JFFCLe+Z84bZSuE+NXEzVivcMi+RQXr2/3IYKERSIn66ZHiMS+NY0iyGo
         xCkkqrJc3/bFA+NVJtxQFAhgLzWyY/6kzzQiXRZ3iTqK7GFqxYazbBRCPaHdVAJEqYbm
         ZINLFgoQDkRXsl8GN1wFnQJ2DWw/3lUrImA9OLQqm811wwQy71424pmSJdAI74E63Me2
         db0qzXXKNtUM4OmrFyoxjN/9dVD/xcRTurg5qK2TwZO971PG8qVDlGSEMU61e7Vf2XFM
         wa8Q==
X-Gm-Message-State: AOJu0Yz6iS0lxHHi0tY+3Sxw8rRCbtl5JDW1gOxlPiHAl10JSKDsz2R5
	HrDZHzKZiIHl6jLvWBwMgTVtp/FCL/Cok07ls1LpgxgnRn1DnbzcWUOVZvn1qm/m/kW6AcObjVj
	FdHbh5zGSw5i1hxqUXRG1P3z7xTCjov/dhIQ84Q==
X-Google-Smtp-Source: AGHT+IHC5qHRCNgF5v0mJ/NwRiwueifsHERMLDkNyQV86+XCpdNDj1A2xATEYvJmyxBcYDAPYdnjCLFWs3s1BdlDqTY=
X-Received: by 2002:a17:906:c2d2:b0:a38:2bee:7a7b with SMTP id
 ch18-20020a170906c2d200b00a382bee7a7bmr2964809ejb.1.1707305033154; Wed, 07
 Feb 2024 03:23:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
 <20240207110041.fwypjtzsgrcdhalv@quack3>
In-Reply-To: <20240207110041.fwypjtzsgrcdhalv@quack3>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 7 Feb 2024 12:23:41 +0100
Message-ID: <CAJfpegvkP5dic7CXB=ZtwTF4ZhRth1xyUY36svoM9c1pcx=f+A@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] tracing the source of errors
To: Jan Kara <jack@suse.cz>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 12:00, Jan Kara <jack@suse.cz> wrote:

> The problem always has been how to implement this functionality in a
> transparent way so the code does not become a mess. So if you have some
> idea, I'd say go for it :)

My first idea would be to wrap all instances of E* (e.g. ERR(E*)).
But this could be made completely transparent by renaming current
definition of E* to _E* and defining E* to be the wrapped ones.
There's probably a catch (or several catches) somewhere, though.

Thanks,
Miklos

