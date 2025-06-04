Return-Path: <linux-fsdevel+bounces-50626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93535ACE116
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC5A1896C8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1C4187554;
	Wed,  4 Jun 2025 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGsfTdml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE561F94A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050256; cv=none; b=CjAgkJzg47camyBVDVvU3pFGArVQbeFrKYviqlxSnChAC9OS2blBFyXG9H8H9XhGHA6Jr1dfA4w7hc86sqLFvgc8CYRZM+XSMX6+VfJ/aoxy8vC9rZ0mWMyWeys4GlIr3OpZiV/LtMMAHMhhEXlBmBpwNo41p9+g+bVPFPtyUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050256; c=relaxed/simple;
	bh=8Gq3Y/uvohcsvzwLNdUtL26ruFEWnJr+Etw5fxSYLMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGGXaESl7yAoZuKODQ0rpS5e1WMavA8hUZaMEMAkQ4fqODkTDYGecPx2N3Wt1xIpzuskpOF54dvxjM7jodS4Cy+aCyYYzc4WUKUr2AL+xsdAwK9vgUwmtm9j+YcdfWc6eqjpxvTmP4GPGfbSorYIcIjGK1P1TJLyERg9da98iKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGsfTdml; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749050254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=17ROtvgVsdbIKrmBl8d/GBNPYAsLTBphWL9RC8WVDIU=;
	b=OGsfTdmlmOkrQZoJ1qgsbdxIuY4n2vmwIonUuMzJgZgxdgiY8Uci3ufEhnbcbi2nRpAMp3
	4B8h09gFYs3ZqKXkObd3HZ8thle4vD2VB9+zxVWX/YNLzm6VP6ufuzI4vN3USdnknmeM10
	wyawj+jRLOeGxQjWwyEqoSeoxJTkJio=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-QgG3UPpyO0eLQW_g0V5hhQ-1; Wed, 04 Jun 2025 11:17:32 -0400
X-MC-Unique: QgG3UPpyO0eLQW_g0V5hhQ-1
X-Mimecast-MFC-AGG-ID: QgG3UPpyO0eLQW_g0V5hhQ_1749050252
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c92425a8b1so285785a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749050251; x=1749655051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17ROtvgVsdbIKrmBl8d/GBNPYAsLTBphWL9RC8WVDIU=;
        b=VkwwpJNaNkF5ADMAFBsd2m3SAQ9Dsvb5UNqb/Fo8dV+VVebPFTnC4B3xgoG1Qtq/Cr
         +0PJnLZBwurO86XMEG+S59QxQtzTcuTytorJJfy6/nyp2GfzGPSOeaAJdwejmk+K6g/v
         /XMT9+df3/D1EuY5BJlNgn9PBTx1E7IjnwQThruUgtiwwmvBBNVkal4nhQ6eiMZDCL4M
         5TRXQcI3huCc5jiVQUQQqbZEwKP2+BFC4kJjpWZE4UF1DSD4uZiM+F9hMw6059sr3zhh
         9qfWIKndjejrhiNuGDgM+Lkv0ws5fE3IdIf3XuocKatS4jZwfmPy0VG283P2otlh64+B
         mwTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu5Gc+tz6Vh1wDQqVpRGWcSonoi96r6vgJdA5kLodbA1sOBqo1nRsC/GLl0ixFWPVvJ6JYczEXrD9Wqikk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7lQBKLCE3PHGNtBxHGSZg6EBi8OChXZU7OKD1vh4jqP6VUDh
	Zn4JkuKY2wtcfJq2WCSQpAoi0Lnq5c4DihEsR0/WU3tHuK2bvhH8U6ulwvvB9+TOYSx3TpYmlav
	enve/h5YUioOsBcmSuayszkWFqZbUbGvbFeKXbTf9/dMnBiRn6/am6ffPjg9xKrpMJr1cUTVSap
	U=
X-Gm-Gg: ASbGncuEpHbLzhSiM8oO2zHlTW/Or9Pm3krhNvLvOFXOiJ4krIA6lYQhIc7Ul9hC0Ft
	ddlVfbVYffK5Zralk++Xp3LVrmvX8E/TNRAq/oMlO7LKUyxmwVbXy3/9kIGZ8T+vXivjCXjI9Q5
	8zZ7LW6IZKxNHNTQjxjGjsogODZlqke6sbwfQh9rU7LAG6AlG4WfZMwelgoqInPX42JgTCFISC4
	P+iyrnJNbJg1FjsCO6HeEe3gG0jPkOkPplZF7sDiRVYwdCT+g7tB+Rf6gF9OftZ6l8Ko74BsQCU
	HrM=
X-Received: by 2002:a05:620a:2b4e:b0:7d2:18f3:9ebd with SMTP id af79cd13be357-7d219a1c83emr460205785a.7.1749050251474;
        Wed, 04 Jun 2025 08:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXQGonqucBZYf2UC6ALyavoKYFeNdR0ADIrtP4iOYjEGlMnFQRQchn5m5Iki7I1+wf+k+Rzg==
X-Received: by 2002:a05:622a:5c8d:b0:4a4:310b:7f0a with SMTP id d75a77b69052e-4a5a56833aemr52154661cf.10.1749050240172;
        Wed, 04 Jun 2025 08:17:20 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358b6017sm91032051cf.33.2025.06.04.08.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 08:17:19 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:17:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Pavel Emelyanov <xemul@parallels.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] userfaultfd: remove UFFD_CLOEXEC, UFFD_NONBLOCK, and
 UFFD_FLAGS_SET
Message-ID: <aEBjfQfD4rujNlaf@x1.local>
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-3-9c638c73f047@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603-uffd-fixes-v1-3-9c638c73f047@columbia.edu>

On Tue, Jun 03, 2025 at 06:14:22PM -0400, Tal Zussman wrote:
> UFFD_CLOEXEC, UFFD_NONBLOCK, and UFFD_FLAGS_SET have been unused since they
> were added in commit 932b18e0aec6 ("userfaultfd: linux/userfaultfd_k.h").
> Remove them and the associated BUILD_BUG_ON() checks.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


