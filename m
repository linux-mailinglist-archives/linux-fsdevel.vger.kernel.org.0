Return-Path: <linux-fsdevel+bounces-71950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939DCD8298
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 06:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28811303999B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 05:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4AB2F4A1B;
	Tue, 23 Dec 2025 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRS6qc7F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D236E2F39AB
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467988; cv=none; b=gq7vgMgmTYbeduwZtYseQI1iR19znWA+PHh1S0taGys0AtJ+4O+2FUHxuOt4m2Br6XIYdHh4Jy+OH2MIYxZeuDoit2P8uk9iMFf4ogSW4W9pM7mYSQwUaof79Xhx3B3tsip9KPE/7sGVVkSDokAJlkSSVZpKgaDVgeF0WzYU7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467988; c=relaxed/simple;
	bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAtkIP0l8dZoRjDcwluDTBZUg7UmJ//Y9OUWj8sKddt+gIlnRrK+HPEJIMwR3XqU2pZDjDXZrAwXX0m3KcjvfkjEv7CI81ZkfedGlMEBCAeHhdXHw5EKtFGSYOaW+L8CK2HQ6466ZKGKl3QAbAeOfUETM2VFU4cAUAF3eRYDA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRS6qc7F; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso2635026a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 21:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766467986; x=1767072786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
        b=YRS6qc7FN4EtduWa68ZXt023TSQiTMXdK7qVlD+eqY53wkWAc89L+baCoLPtatoQNV
         nRV1kqExU4x0Kq/7nLf23qk+jbHPJl1ohW+d6khZJaUUSHKu7UEyHFcuAq3mVyZfVs2E
         mTs3xHvhMuxCjBsNRAzGXzVyQIm1hFrGsZkIVSNA3tnwpvXfk5MxMCrp1htANa4luD++
         f1I0ejIHnRULvDlp6uuawM2q3dtIwL6o3ClXqX/3lAzNiyqtoHm6/1AckOVeDCqzznAA
         cvLnp8ljOlrbS/ahjo6lewbqz/tmL6Gf/oJ28nvKtLYo97aUsLsSQU7wgUM6LnBxyHtH
         UOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766467986; x=1767072786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
        b=GSBtvBtcIUb+0in9d4HizKLEeGhbmTsgGtgxZOYyLk0EOn6ZZ3+6wihDTJPptYgSmj
         g1XM1J7k8/G2bD+hs1TZldajyvJczDCrIOMX/UTCTz4p0C/XW8dTiNIP0h8NvLpeDvf/
         Ye/EY2+X3FatE9KLdn6RGXsa130a20Kzyf1hy+gQ2UbMt9D4rKLCnEG/TXz7VcR4CDia
         imJhLISJNP/OsppoPywqFt8zqhaAqV2JkhPjnx+ywoRDm7ttVBc5H41EHihUTBpFgB7z
         Iw/485R2d5NHLPKlMK10Gsc0pOMo1rAyNvUYNXMafnaTZ9NSt1pTkH5Cgj37nJRGx+ER
         5wqA==
X-Forwarded-Encrypted: i=1; AJvYcCUOLxZyFsgcXK3mG7TrPWzDJniXU3wZPH3x9Kg8hbecwpYSLepUAMRnWvLdrvfBRlAGEKujZLYKwJFv8bQe@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMe6zHfsrnmqxEQx2JHN10eTeNF5OZA+TjOa+k0JhqXgsdS9p
	bci5G7mOxidrKYrNs9nedbkl81o4YUmS9RGKzZ2BkYbZl+FkrwKSz5Zp
X-Gm-Gg: AY/fxX6x5izhv/vnp+9TPGTfwSxlx6TkwEQF0KL5Fl3nUpSkxbvHFc6uw6oBwuatmdH
	PJjJEtnpA9MJYzybeXo0Ek4lWO4dL4cp7+fhvV1nrLK37QusdC/i6WMxCkBtv5btp4E7qE5X3ZH
	HB13aY6fEYLQQk5+TTo7QJvZb9XkO20vBMPtIcnvQZf/I0VAyhspZB1AMwu9WJ4zzhFFreDZHDR
	dcLHK+jgicadljGlCbmQQmiz3WNodfEoZte2UUWw27wZABozP9V0oA941SUjboMNc3bTnBxhl6s
	kLZvMYI/rT13Wwx9M5O+35BXRiwJQbLf/uWIo1ngU+MMrJbdpkNoSazj+6Hm6ALZ02ttRWZsJ/y
	MY7idfMjzjT0JBy+cZ5//FXk02hYWwBKj+taxd0s/cJsS+P2mvtQU2MVUjYdP+n581HiGxYtebm
	cA/3CWUPwPBOCuy0Yg/+BPnyryNHLcUJmZFNH5InTRcnHQfdTnLgdfdNZzskZ039Fs
X-Google-Smtp-Source: AGHT+IG5Qf4dCPxqVYyhhZiZ2cPZHWZcc5Jl8Dom3Sf+VbFYEbzUaslYB9RlXBdrrGXOm7O8E9bw2A==
X-Received: by 2002:a05:7301:1a12:b0:2a4:3593:ddd6 with SMTP id 5a478bee46e88-2b05ebb6038mr11158060eec.3.1766467986000;
        Mon, 22 Dec 2025 21:33:06 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm54002618c88.0.2025.12.22.21.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:33:05 -0800 (PST)
Message-ID: <12bb96b6-1e2e-4f53-b4ea-1fae2500aa21@gmail.com>
Date: Mon, 22 Dec 2025 21:33:04 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] fs: exit early in generic_update_time when there is
 no work
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-4-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Exit early if no attributes are to be updated, to avoid a spurious call
> to __mark_inode_dirty which can turn into a fairly expensive no-op due to
> the extra checks and locking.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jan Kara<jack@suse.cz>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



