Return-Path: <linux-fsdevel+bounces-21426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8391A903A08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBCEB231F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410D17B42E;
	Tue, 11 Jun 2024 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgV5M1cC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040617A930;
	Tue, 11 Jun 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105217; cv=none; b=mruRQl1EtuX8gPArvFWteTF8UaCouY6gbnLdI4pDoWEIM7n7Ry24yZIUOWqmjZ1WI16QP67toKzoYrFD3YcRM/Rc2Q46fUWllsav+/Zqz8uz6DxF+jqkCtjcnpExHFssB6z4TLCmrgbjB03P6fyzM0c/gjXQNltLbt0JRaYpUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105217; c=relaxed/simple;
	bh=0vttU6plmC/ACJPGa8Cko9Nk6HM7dRc0+cN+OvUCcGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mi2Xqiy0opMEiuAwciNN+saBo18vTaUebMqzjymq/Bu2N9zDH1LfhmUt3soIpWcDuEG3R7tth55R1bVLkG4FE4HQYxcJn22WJ+EMZE69dJGFipP/WpHW7t5TxCwz/j27PqpxiLxFhU5t74ZM3J4vaEm+taYFRHg8hgGxZea9ac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgV5M1cC; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eadaac1d28so49008711fa.3;
        Tue, 11 Jun 2024 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718105213; x=1718710013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ct2faOqflrZfkFZbWfpkQItxoF/ht0542akQkf4ySIY=;
        b=WgV5M1cC0afnhw5hOemidlXmsBNy/WPVGm9UmP7o5v9JmSNYZCD0qxFRN5MT5ZChln
         1UGv3eogE0U9rcabdYCKgapEJIX6zK22vkYt1SqitWeEMk0k85g+M1hlwy3htgTzjhY0
         0F4G7xuR3SYnFu+OBJDwj3Eg/V9sT7CAP/Ev0OnA7MwG++d5SzeZbbSkH+zMPL4tQVXg
         SABAi+BC0aWFj9zwU/JzBFsYQ2ZX/eBYe/6QJreHtoFP4IPAShX1L2RiexEbrJYSUWKW
         x0qGa0xA0Gh+iq7BDNhXzat8I2RU5RWY6eng9euATLpk9815rIcOkZ6Kb8XqgAk9jb8u
         Gsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718105213; x=1718710013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct2faOqflrZfkFZbWfpkQItxoF/ht0542akQkf4ySIY=;
        b=ju6U4cpcH6LmvdiYxU2um/SEYkwslVdGZ7JCgthg60i1CGkJI++x9t6JCY7JpmRUJT
         T96p8/ITAnL57Hf3HCnqT1WR8Zz7v3Bh3ANz4F6qWE/6vcOYlrVjKVRRkrrxI7rC8tbm
         D1wziP4PhaWxbAA9vuFCdxE9X71QyRX3flr1m10fR0HJiddfVHjYiYYTKHQShpk/AkJM
         3DzZIcBWmIoo+VkIUkwcoPoq/lEQ4plWwcwq0VJIZRb3Pg5QWept3maWCWweR4C7ckfp
         oEG3k7IHuAeRf3A6jmtUSCB0wNCLgt87FC9EFkJsF4Gk4vIhjS6Z2iP/S/lycNXj+b0Z
         AVNw==
X-Forwarded-Encrypted: i=1; AJvYcCU+3upz1aXTJnp4TmphPCCajjkFdvjFlS0k0oDiNwohugUsVaLuhOnUIt7YD/ht5LnhlYMpndhMd/zduEEvwJCg9yBOWet8beUgzOmc5W3SSwk5k7TiQ3kPar41LEru7051IQnTE4I2n1xMrQ==
X-Gm-Message-State: AOJu0Yx9R9NZywxSCXlHV/49eFFQMG6d8kxlrg+x/kQh5BuWChtXABAv
	zFTef+D1e1VW/Cj8dF0JgsX8Iw4ubwSj0ZORTPGfYvswMZjSwMMV
X-Google-Smtp-Source: AGHT+IE3P08IT2hRBHsTqRhuv0QKHHCpAJ8Z9VeZ+FU2dD5sgpFhSKahAInBi3AaJDmjs7NkNfUuXQ==
X-Received: by 2002:a2e:a988:0:b0:2ea:ea80:5328 with SMTP id 38308e7fff4ca-2eaea8057ebmr71681461fa.45.1718105213204;
        Tue, 11 Jun 2024 04:26:53 -0700 (PDT)
Received: from f (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1a7c663asm8277814f8f.115.2024.06.11.04.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:26:52 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:26:45 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: partially sanitize i_state zeroing on inode creation
Message-ID: <q5xcdmugfoccgu2cs5n7ku6asyaslunm2tty6r757cc2jkqjnm@g6cl4rayvxcq>
References: <20240611041540.495840-1-mjguzik@gmail.com>
 <20240611100222.htl43626sklgso5p@quack3>
 <kge4tzrxi2nxz7zg3j2qxgvnf4fcaywtlckgsc7d52eubvzmj4@zwmwknndha5y>
 <ZmgtaGglOL33Wkzr@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmgtaGglOL33Wkzr@dread.disaster.area>

On Tue, Jun 11, 2024 at 08:56:40PM +1000, Dave Chinner wrote:
> On Tue, Jun 11, 2024 at 12:23:59PM +0200, Mateusz Guzik wrote:
> > I did not patch inode_init_always because it is exported and xfs uses it
> > in 2 spots, only one of which zeroing the thing immediately after.
> > Another one is a little more involved, it probably would not be a
> > problem as the value is set altered later anyway, but I don't want to
> > mess with semantics of the func if it can be easily avoided.
> 
> Better to move the zeroing to inode_init_always(), do the basic
> save/restore mod to xfs_reinit_inode(), and let us XFS people worry
> about whether inode_init_always() is the right thing to be calling
> in their code...
> 
> All you'd need to do in xfs_reinit_inode() is this
> 
> +	unsigned long	state = inode->i_state;
> 
> 	.....
> 	error = inode_init_always(mp->m_super, inode);
> 	.....
> +	inode->i_state = state;
> 	.....
> 
> And it should behave as expected.
> 

Ok, so what would be the logistics of submitting this?

Can I submit one patch which includes the above + i_state moved to
inode_init_always?

Do I instead ship a two-part patchset, starting with the xfs change and
stating it was your idea?

Something else?

Fwiw inode_init_always consumer rundown is:
- fs/inode.c which is automagically covered
- bcachefs pre-zeroing state before even calling inode_init_always
- xfs with one spot which zeroes immediately after the call
- xfs with one spot which possibly avoids zeroing

