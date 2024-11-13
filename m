Return-Path: <linux-fsdevel+bounces-34592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA5B9C680A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 05:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FD81F24B5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 04:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619041632D6;
	Wed, 13 Nov 2024 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fz8xbBJb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350D230984
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731471761; cv=none; b=QOSVtBFdI4nR0krl8IOTB+qIZSvDuCFlxO3+7IegzejDw3xiK7yXFEljAWKlazCZ+5rZtuEFuYyAEeyI4HIRHdruDiNQSCLxJ9l8eLnNLy3QODaAVoXfdvXoYONKapbelP0jTPJ4j/rxNnhGynQmzVh7g2LG7SE1OYTna4fxMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731471761; c=relaxed/simple;
	bh=ljrXITTwwHVeiWnm7jpkhj4JsmPZBseyOyzLqp4S/0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QP9ZKM1DkEoqt5SNTNeRpc7Pv4YKY12hXCDxZQ7F/WfThUPrwsNmiEyNF1jsULXuFzezL1Jf/xrdCusbJNPfQKLw/pnR1MfRf6noqs1KX14NWmxxFZYoaOxYpnTfuqrsWJWoJX3Y26IaI91v2qawz45tIPpAaUtWw1gPJXrC/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fz8xbBJb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cd76c513cso54846505ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 20:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731471760; x=1732076560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I15SKHIkeVAMdJYrxLbl9iQQnNRGVNPzHsQow9xA5Ms=;
        b=Fz8xbBJbBDgaX0q4ItCsoiJwJS8ZzIxqDNLuiJ4f9JS+lcZnYhyCoNoDzrEJ1EB/Dt
         S79EsvW0F4yNiOhzQqfkqaNZEbgDmuiUv6NxUNKHl0DXHdcl2glWoaACsbCraZCSSPEs
         +jWSRzvoYw1RgTlomlbkWGn1jkgdL3awJSXQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731471760; x=1732076560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I15SKHIkeVAMdJYrxLbl9iQQnNRGVNPzHsQow9xA5Ms=;
        b=np+N4VskxuXXTm6liWESntL/GPBj9rk5DBmY0mC6tx+3Bw4BYWu6sWtvGjDKsEC4Gw
         +insl31nMvtmePXki5doQ5sp0Z1KDLLxSLxPXjSzkANmidkMwf3bbszFhWHQdfxLenJB
         4dcFnf9ERJ01QuaJAwI3qbywxkVoJhnAK7U8LOrp073Ceu8+xcGujmbOPe8yq1hGy6ya
         /FHZufnTkBZ0zP4+Fh2cD49n8RALGsYxMibD6B9hB38qT/iJ98VvaX0BJfK2JZIY9KLt
         4lYDDDkuuQfIztu/kPQ03nfDee4uZYX2lCC4QOAzP6HzXJzax2LbHQFf49lB7fRkYjM6
         /RDg==
X-Gm-Message-State: AOJu0YxLP5RlwOI8UDOXtg3UQrUsTwf3Q3XbhKipm/n+8JEM1MPAufWB
	urR/tz2gOqSdTesbP6nUhlIUWGbsYU6Eqh5lbyu0h0gYJVwMUbr+IF4M0y6e1VVLbUZDGTdCI5E
	=
X-Google-Smtp-Source: AGHT+IFThtQq5A5jrepecVTbpWTqpiBqOCVfMg/nvDDc3sElxjgP7CCP8EvoOpwh1VqiHWhYXNY3jQ==
X-Received: by 2002:a17:903:1c6:b0:20c:a19b:8ddd with SMTP id d9443c01a7336-211aba2a94amr66132285ad.51.1731471759719;
        Tue, 12 Nov 2024 20:22:39 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:50c:65db:bb29:3cca])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177cfb0ecsm101529095ad.0.2024.11.12.20.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 20:22:39 -0800 (PST)
Date: Wed, 13 Nov 2024 13:22:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 4/7] udf: Allocate name buffer in directory iterator on
 heap
Message-ID: <20241113042235.GG1458936@google.com>
References: <20221222101300.12679-1-jack@suse.cz>
 <20221222101612.18814-4-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222101612.18814-4-jack@suse.cz>

Hi Jan,

On (22/12/22 11:16), Jan Kara wrote:
> Currently we allocate name buffer in directory iterators (struct
> udf_fileident_iter) on stack. These structures are relatively large
> (some 360 bytes on 64-bit architectures). For udf_rename() which needs
> to keep three of these structures in parallel the stack usage becomes
> rather heavy - 1536 bytes in total. Allocate the name buffer in the
> iterator from heap to avoid excessive stack usage.
> 
> Link: https://lore.kernel.org/all/202212200558.lK9x1KW0-lkp@intel.com
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

JFI Looks like we need this in 5.15 stable, because it now has
e9109a92d2a95 which produces very large ufd_rename() stack-frames.

