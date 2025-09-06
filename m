Return-Path: <linux-fsdevel+bounces-60403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409C9B468FE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 06:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023BA588B35
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CEB266F00;
	Sat,  6 Sep 2025 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6M4uuFt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326D25CC70;
	Sat,  6 Sep 2025 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132706; cv=none; b=h+QL3aa/85WStwny2gyPSWl/ym9kIPkHR859Wg5DqSg3frXSA8LYVoHiW5i6F1NW+aO30MJHkM9lStz071Xp4nhxz0UJGufb3/npmR5hMUtnjsYixSF2STEMiGglABlH/zMOuNZ6dlHcxpnX1MBQD8uCUrdP3yUz8Gr5qAWYnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132706; c=relaxed/simple;
	bh=YhsUb27WIzOKdihnuSLHCUNUhjMrtFA7DwyR95YFpWY=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:Date:References; b=DZhrAy69UPrhiJPopuNdls7WzhN7L/Zz9e3Sa+m0B5zJKTPH00G6OxXJpokrvAUemEDplVOLbFCZql4GTotxG2rdqZIwIvl4vQZpiIG2pViRIfpi5gyN11gW5Qt351rgRg/7mTpdduupOfRerhEb1frC8IrR6PIx+AXzlsZJc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6M4uuFt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445805aa2eso27539095ad.1;
        Fri, 05 Sep 2025 21:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757132704; x=1757737504; darn=vger.kernel.org;
        h=references:date:in-reply-to:subject:cc:to:from:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QElD8wXiacOLfhe3S6yPmyccncw7eb/dDH716ro3Mek=;
        b=C6M4uuFt/Cdhv3PW7ofcQGdRo1eQf0L6RYMjWBMALWnLzAEo3V+5ptmY7s1VLvxf60
         qROpBja/EWbrf96BdvYIDLgO8rScXPXr6cAV2ZbfNTfLe4gkPf4mupbq0jYe7KMHQ90Y
         5GQwqAtwkmqScWYl86bkh2Gbsu2qtwzG3sp6k21k4an4PBzQ7jSxFzGFGJDo+QKak7tz
         1A1Nyq6uWInIHCYf4Ty8MGt0oMfJdfJrL7TXTREIvrab/ABQUnosvxM43XTYdmVlujDY
         iagl619gZi54sxU6uvT3uOdWLWAusASoTniIKWpzHOyuyi6DMStNw0l3O+q7f7+xVeJB
         Ssgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757132704; x=1757737504;
        h=references:date:in-reply-to:subject:cc:to:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QElD8wXiacOLfhe3S6yPmyccncw7eb/dDH716ro3Mek=;
        b=dF+ctMsBp7sCYnCudynFOKDP+cV+BEfXHJWs6tm6vOcPtJY0d9dUsR7NQr7hbB3FgO
         pWmI6NhBYn+60+y+xvZlOyHaXVEFWfIh1KrufM8dVlDN+9wtMKk0Ap8EGIbk2swxPHc6
         BQ3d46eqY1QOAL3VhTeT8Y9PSaz6z9cPUfOvnM6bn+wpMXN2sDWY5zoEnloR3qzO6oTn
         0MoJLTc0WjzNgwttneytFuQn/T6szSsz1EqVOdGqH4+eWNhdZZx8VJQB8WlRzePpcdiL
         Mek+RRPjM4PnKWCZDgTTjbk00iW+S3k7vtewvGa2U4iD9mtg0dNBPMcxOBC0N57VBTYw
         jdXg==
X-Forwarded-Encrypted: i=1; AJvYcCU5wcX6/k3aIhVktMg9lkspReonifwSSyqyccrREkupbBfJAgCgkOgeBk5gADMBPzsGZIhBhichE13Q@vger.kernel.org, AJvYcCWK2za02Ut5Ye2IBJNyQ0tjlTiCqDxFiiocJvbE2jhssa7nKQjq1rR3HiIcJoI4C2ELqimk7QRxl7NvziIcLw==@vger.kernel.org, AJvYcCXNxiaeUB3leGsH+GO3NFw5OkL7HITAUJ4Eh6nHUvTHNiwJnobFJZc7v9Z3OmGfQMdQN9jhBO7Mtom2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+d33LHekmOK5Kj1qHndSQ4JoDNOOenvrMtphqhXG1iBWMvyBH
	8Y1YVOlhQJJ2qUxSeZSCkdFftsoQMZA/Ve2VXy1cLsIjID037oAl8buyzlp56lES
X-Gm-Gg: ASbGncv68Z+/FgxRXVk+GvNqd/tUO0KTMKeEJyTheJNdftUm182iT3vQ+YsNoONQ8ob
	GltKOk/cZ/K5nxtFvlJBpU5BnzqTme8OuGlYm3TxFsyB4KcMO0YWcBFTtyrbcHzD/Q06PBJvMK1
	Aj91bIYKkUwEBMpT+iatWVSJLGcMURDBzz11EGR7jRiSoZZ0UEgdFmzKzuj/Y5pCWOZsFXnGGtB
	/kluX5vI0eS7Hx1YWcifTQxxKLSce+8SDn8oWY9QEL4OlLh3/4BAu3Jf1BF4tgO3nPlwYurYkOR
	Ev/iNdnUWP83MIBfCmn16jHI+2z1/Y127oVrS+sk0BgFSy85zCQk4hLmJ26XWCspU8+RPHC7WeZ
	mdtFUgHooO6M9QfVQ9rKebA9sdQ==
X-Google-Smtp-Source: AGHT+IGzuQD3i0DP0tvOfpvMv3rWVNh4vgySwQb8oqq/FvWMYWrqPd02bnwMpUdY86Qzqt12vR5KEA==
X-Received: by 2002:a17:902:d482:b0:248:e3fb:4dc8 with SMTP id d9443c01a7336-25173118fb5mr12235285ad.39.1757132703982;
        Fri, 05 Sep 2025 21:25:03 -0700 (PDT)
Received: from dw-tp ([171.76.82.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccc79a345sm53894025ad.132.2025.09.05.21.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 21:25:03 -0700 (PDT)
Message-ID: <68bbb79f.170a0220.1880ae.2f12@mx.google.com>
X-Google-Original-Message-ID: <87plc4i4z1.fsf@ritesh.list@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: jack@suse.cz, djwong@kernel.org
Subject: Re: [PATCH RFC 1/2] iomap: prioritize iter.status error over ->iomap_end()
In-Reply-To: <20250902150755.289469-2-bfoster@redhat.com>
Date: Sat, 06 Sep 2025 09:53:46 +0530
References: <20250902150755.289469-1-bfoster@redhat.com> <20250902150755.289469-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Brian Foster <bfoster@redhat.com> writes:

> Jan Kara reports that commit bc264fea0f6f subtly changed error
> handling behavior in iomap_iter() in the case where both iter.status
> and ->iomap_end() return error codes. Previously, iter.status had
> priority and would return to the caller regardless of the
> ->iomap_end() result. After the change, an ->iomap_end() error
> returns immediately.
>
> This had the unexpected side effect of enabling a DIO fallback to
> buffered write on ext4 because ->iomap_end() could return -ENOTBLK
> and overload an -EINVAL error from the core iomap direct I/O code.
>
> This has been fixed independently in ext4, but nonetheless the
> change in iomap was unintentional. Since other filesystems may use
> this in similar ways, restore long standing behavior and always
> return the value of iter.status if it happens to contain an error
> code.
>
> Fixes: bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> Diagnosed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---


Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>  fs/iomap/iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index cef77ca0c20b..7cc4599b9c9b 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -80,7 +80,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  				iomap_length_trim(iter, iter->iter_start_pos,
>  						  olen),
>  				advanced, iter->flags, &iter->iomap);
> -		if (ret < 0 && !advanced)
> +		if (ret < 0 && !advanced && !iter->status)
>  			return ret;
>  	}
>  
> -- 
> 2.51.0

