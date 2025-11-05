Return-Path: <linux-fsdevel+bounces-67183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6085C375C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 19:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A473BBDC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 18:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9902F31BCB8;
	Wed,  5 Nov 2025 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SjKKMhOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A662BE7BA
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367631; cv=none; b=TuVVSe08xEQ8iULJH6jo/2kCYXA+26Ur1tzmRuvJvQB4Zpt7ysKP2Vg6YVB9vLOud+AVwzTscD7Zx3LNtVZvYS+pe9s7Abm6PNSuya7Y4EoyIlhhW2letWxC8KB8KkIIpXEiwAREm4CRdB9srxoDoevqR9cXBJX2ZXJ+884DTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367631; c=relaxed/simple;
	bh=QdIsCbGU61ikoVL7GQujIgBmKZhEQF493waeOpnzVho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cg15ZKSEY6ygUBuQdQZUc5rn2BnMR3My5CEWSRXIt1nnws9ZC6wJqROkDH8PqeuTtFRRqgpDJTwUABtpotwBCnxL0WhvmE49rKLrZ/jixY32hKHxrnYWd1B9d4xExjCajY6gnkCfNufsykQjNznychW40nJCCuxhtTmCszJgc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SjKKMhOk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c48e05aeso109355f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 10:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762367626; x=1762972426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw9BgXv3xuEvlMmxJm1mpqDieF/LQYS6cC55AYGAEG0=;
        b=SjKKMhOkVclgt5wp06tjOozRABfkZ157n3Ix5SYUyCzRY+YcIQn4QR4INg0zTXV7c3
         XQqAs/5SJF8dWArGKQr5D8jX+CBl8EQVU7u+hurVf1xXm1M0uR3lMX+wHxb8vRNPuSPK
         x4WoIBrMnpNbP+QNvjLsL3J8WYSLS2PzrFwkVegZOaDDYG5rYoQY90YxxZe2tqFrcVZ/
         NsAs0WqPGEAVPNGME6r72Hs9paI8xPPjpmqTY97a0odiAAIGcM8+DhblCWihcvFVsiCq
         v42x1ScK1W7eFMjWRS/gnctfipQXCjKwSEDOC/acfQ41eI3++x+s0/1tRNrYLaCQPmfx
         A5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367626; x=1762972426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xw9BgXv3xuEvlMmxJm1mpqDieF/LQYS6cC55AYGAEG0=;
        b=w6N4Ez04F4x9zLCCrmsV9o0cGlTyHWSdtfe/Ifitnr99zmi28NmUh3tAmMdJSqcL8Q
         CB5pfb8demRyPlFIM7gFyNMSMRlnjyzKB/EchXNEh3+kuxEDE++CFQgiKxyk+pdO16B1
         htVfPGYPqMxCante0C+OXqwLc9ZF0vS3eHVyD0CQjJNa9d3VfTyqjZb02s1nnWbzP7Gv
         RDqcfdtcn/zDwQCllM675zlO0wTFKgMR2y/bQRgzbsUI+bXual/J+0zEvwO1ENJJ+T5a
         vcWcMw8YRIw5fRsN7IUQhRuz8RJFndSy95b+7VRGthgWrICbTAckkzECdi3BBbKZRuxv
         fmhg==
X-Gm-Message-State: AOJu0YzGtsBGbuOE8FRzsCKEhPVWDvigCWEh1vCdyUX5enNa5sPBRC6W
	DRkuHXi1elZp/0G/TpBQzNUcNbIz6aC9lr6VTDsNiOVfUBpGv5a31zDvYmnz+OVf7E/zpnLOgU+
	RBsW/Jch8LHj5qeJ0VK2C0EkaOFjvmKJaqOTRtUM+SQ==
X-Gm-Gg: ASbGnctl1xGk0V4+xYlsH8hpuG5ZsZthI1gq+SRrKLllBhkOAAC2Z5cBVuVyWMZBmby
	T9oAdlFVamtAmv54Q0eLDAP8Ib3HGnI+dK4KQf46yvyVS9u6NI8ZTLlzIr63PjqWCO7uPL+MhRA
	vqVzzh5rUwakJdQ/DycaeV3Nf2C9LNFVW+Gl2LqyoJkg3dZRXh4HUDl3CclEh9QukI/6lvuF45j
	3o3AH1yN5GXvnx8yBT4kUN7/e23/3geObeAOxOwcPWGLVuq9ZFCHwMMrev9MmF7nnEx6axPcZyt
	dfuePLj90OdNQya6ZpIRyS7f46dD/lPYj+X6DNOE/y8/bt45NAEpltV7+g==
X-Google-Smtp-Source: AGHT+IFCZTc3E2XHwDCl+YRtQQFR97QktfT8RGPDVIDrhNNHjq8LIXQFn/CmjbQ3aTH0Rp5kdEDKiM0TTWzYhWFlzC4=
X-Received: by 2002:a05:6000:1849:b0:426:f9d3:2feb with SMTP id
 ffacd0b85a97d-429eb18aaacmr432745f8f.23.1762367625965; Wed, 05 Nov 2025
 10:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org> <20251104-work-guards-v1-5-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-5-5108ac78a171@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 19:33:35 +0100
X-Gm-Features: AWmQ_bl6PadzQPI3bpD_bJBLSeiXboTP6hljfgJQkUA_P8mn02EqfL9ZuICWSd8
Message-ID: <CAPjX3FeEZd7gX1OeCxRXrdBMafHOONB2WQO_JOZuxKoVEygzuQ@mail.gmail.com>
Subject: Re: [PATCH RFC 5/8] ext4: use super write guard in write_mmp_block()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 13:16, Christian Brauner <brauner@kernel.org> wrote:
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/ext4/mmp.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index ab1ff51302fb..6f57c181ff77 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -57,16 +57,12 @@ static int write_mmp_block_thawed(struct super_block *sb,
>
>  static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
>  {
> -       int err;
> -
>         /*
>          * We protect against freezing so that we don't create dirty buffers
>          * on frozen filesystem.
>          */
> -       sb_start_write(sb);
> -       err = write_mmp_block_thawed(sb, bh);
> -       sb_end_write(sb);
> -       return err;
> +       scoped_guard(super_write, sb)
> +               return write_mmp_block_thawed(sb, bh);

Why the scoped_guard here? Should the simple guard(super_write)(sb) be
just as fine here?

--nX

>  }
>
>  /*
>
> --
> 2.47.3
>
>

