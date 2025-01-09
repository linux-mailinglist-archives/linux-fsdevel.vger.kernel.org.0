Return-Path: <linux-fsdevel+bounces-38725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C45A07233
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 10:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58148164044
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCE021766F;
	Thu,  9 Jan 2025 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNPOOk7j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B2214808;
	Thu,  9 Jan 2025 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416243; cv=none; b=U47ALMSnD9x10yI7iYWd76x0qX/02KoFVPr9YMUJ5+/lhWsgZ3l/1NHzHaX+dHmGQe17jqFDCz0DdpWZ1wCyGbiHJ+2+ZRtkKFu8W/0e2MhiAXuRd2+Dl341bTfEE5zJbjlS+DRqx+MXn312Jievxu3nOyQV9OuycSFn+bbBbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416243; c=relaxed/simple;
	bh=QxW0YnCh4Op2rTt0Nx+fhzd5s7rQ5RCcgZ6nyfZnHC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De63XP7oKRISj44AblVGeSWuQsEj4JUCwIqpNtj77fe1RBU7LtG6gVQ4mRoxajqGDJrCelYo6xbNL9uqpmAEdLDbfHwU5a97frG73MStjTnkVBLuG2JcangbKxUsy+tzJcXt7yAZvgyK3Brpzfrjgy77tn/u5h5zjigLCGvv6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNPOOk7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A08C4CEE1;
	Thu,  9 Jan 2025 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736416242;
	bh=QxW0YnCh4Op2rTt0Nx+fhzd5s7rQ5RCcgZ6nyfZnHC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DNPOOk7j47wmJFW8alf5lxRakO4z8uVBhXYR9UxQ1yveTB6p4nRRKwP1DC4PDHI85
	 yybxml1iVML0L8AtR4OV7MGmW1gDUUssGHWFKBNnLkfnm8uV7YXt39acZNiJDr3ZtC
	 YAx9HH8XmPubO1XhwRTvlbz9MbD3MkeAfoOrS0r3QFrqjZgYPFsLk0KApkdu4a+YWc
	 KkYmT9I9PEeTkYL1Xn1i7J8xpQU3B4nmRUf/n6GZj5xniZ4s7cPW44WKTjdyaWDfhc
	 +9ZzbzpQ0IkihmqXbG8zTNh8rEQZI5FPNv+EoD6oKxY5LEnmMgLUJ5srnwOVBeU6+N
	 682+YkB/Z2z0A==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401e6efffcso758027e87.3;
        Thu, 09 Jan 2025 01:50:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWH7sOeA01EG8/pGNiq5NDC97HQnpuhAysIhr6V5hXDorro2MOiQ+0CbpsCechf2k4VBy8NPqt/rnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1QnXTDOdL8pBGfKjCxBR5de8bBigP71iw1nWPlBTx7Na0du2
	KOclL+UnDLgmyeK9Cz+nu8mlYyCLYTra+SVSXnsLEnYTGawY1mefJYNBIIPeSoAldFMRcNz5Ulh
	KkUXxFAqcpHcfSZq3nqOe+/HjzEM=
X-Google-Smtp-Source: AGHT+IE9vSHLJMB/9vMrNNGtMs3kSYmpVMUCgYuG56Np0X2+klv919g9mQwblyEV5YGfVTD8sAZlMRb4awOWEQM6qvE=
X-Received: by 2002:a05:6512:401e:b0:542:1bd3:bc47 with SMTP id
 2adb3069b0e04-542845d8670mr2243839e87.31.1736416240821; Thu, 09 Jan 2025
 01:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Jan 2025 10:50:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHy+D2GDANFyYJLOZj1fPmgoX+Ed6CRy3mSSCeutsO07w@mail.gmail.com>
X-Gm-Features: AbW1kvadMVFamQhugcJIhHigDGsbT-fk1duHP7ziZB39LrsSMRkLmN7ElSJJLSE
Message-ID: <CAMj1kXHy+D2GDANFyYJLOZj1fPmgoX+Ed6CRy3mSSCeutsO07w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] convert efivarfs to manage object data correctly
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Jeremy Kerr <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jan 2025 at 03:36, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> I've added fsdevel because I'm hopping some kind vfs person will check
> the shift from efivarfs managing its own data to its data being
> managed as part of the vfs object lifetimes.  The following paragraph
> should describe all you need to know about the unusual features of the
> filesystem.
>
> efivarfs is a filesystem projecting the current state of the UEFI
> variable store and allowing updates via write.  Because EFI variables
> contain both contents and a set of attributes, which can't be mapped
> to filesystem data, the u32 attribute is prepended to the output of
> the file and, since UEFI variables can't be empty, this makes every
> file at least 5 characters long.  EFI variables can be removed either
> by doing an unlink (easy) or by doing a conventional write update that
> reduces the content to zero size, which means any write update can
> potentially remove the file.
>
> Currently efivarfs has two bugs: it leaks memory and if a create is
> attempted that results in an error in the write, it creates a zero
> length file remnant that doesn't represent an EFI variable (i.e. the
> state reflection of the EFI variable store goes out of sync).
>
> The code uses inode->i_private to point to additionaly allocated
> information but tries to maintain a global list of the shadowed
> varibles for internal tracking.  Forgetting to kfree() entries in this
> list when they are deleted is the source of the memory leak.
>
> I've tried to make the patches as easily reviewable by non-EFI people
> as possible, so some possible cleanups (like consolidating or removing
> the efi lock handling and possibly removing the additional entry
> allocation entirely in favour of simply converting the dentry name to
> the variable name and guid) are left for later.
>
> The first patch removes some unused fields in the entry; patches 2-3
> eliminate the list search for duplication (some EFI variable stores
> have buggy iterators) and replaces it with a dcache lookup.  Patch 4
> move responsibility for freeing the entry data to inode eviction which
> both fixes the memory leak and also means we no longer need to iterate
> over the variable list and free its entries in kill_sb.  Since the
> variable list is now unused, patch 5 removes it and its helper
> functions.
>
> Patch 6 fixes the second bug by introducing a file_operations->release
> method that checks to see if the inode size is zero when the file is
> closed and removes it if it is.  Since all files must be at least 5 in
> length we use a zero i_size as an indicator that either the variable
> was removed on write or that it wasn't correctly created in the first
> place.
>
> v2: folded in feedback from Al Viro: check errors on lookup and delete
>     zero length file on last close
>
> James
>
> ---
>
> James Bottomley (6):
>   efivarfs: remove unused efi_varaible.Attributes and .kobj
>   efivarfs: add helper to convert from UC16 name and GUID to utf8 name
>   efivarfs: make variable_is_present use dcache lookup
>   efivarfs: move freeing of variable entry into evict_inode
>   efivarfs: remove unused efivarfs_list
>   efivarfs: fix error on write to new variable leaving remnants
>

Thanks James,

I've tentatively queued up this series, as well as the hibernate one,
to get some coverage from the robots while I run some tests myself.

Are there any existing test suites that cover efivarfs that you could recommend?

