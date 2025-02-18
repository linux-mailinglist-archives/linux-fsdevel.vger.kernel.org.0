Return-Path: <linux-fsdevel+bounces-42005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC1CA3A10F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 16:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2643AFB9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5726B976;
	Tue, 18 Feb 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBmbLvmr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0826B94A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892178; cv=none; b=T6imWXAdJ8FnTlryJzMpp9J+V0jPzximifpasKBEmS0hxgo6Dl8fyxBcMYeBHyIFzrK9529p4D7eR0UOOeKvEZmJDVXW+9nkqGLAPpTVQI6dKfI8VtZiJrFGA0o6RWfgGwS+GmzhQJoBdTgCkWh1awAzZHrkZtj1CMcLjn9s8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892178; c=relaxed/simple;
	bh=dRqns3tgs9LOzsvNykyA2wnDs4hZV04yHkHiuozwTo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NKN4C+aoj03sA2SywZ8EpghqBdfvrshHCItqFiPlbC+WSUU/SQ8icZZXyPfoTVgPm38rlVMioxoMB/nbIEe6cmQW0LSHX626rGMOFASRqUWtTk0OWbTowtoZScayjUPuCMBA4vXQnVSutsSzWSgQoOSEb+0D9m7Wg1iarckMxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBmbLvmr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220ff7d7b67so75974605ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 07:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739892176; x=1740496976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4rBn1loiHVRgqEEQSp4qIiIQysoefBUpVmMVONI/VM=;
        b=bBmbLvmrD97265On5Lpt5wPjTUlVv8Tnqf41bK7fBmHxacgA9JJarrnD00NEj3okig
         Ti+cAqFrIibuzEPEuC1OInlzjhtGlrUd4dCKw7EjXunauSACmvEGAcQkbk73SArVVzR2
         w0mFtKmR3AjrRTc4D7+y1Qy3dIKO5bEzoi6C0+0eu0k3yqKJqGAVGXM+SqPNLMsIfVhJ
         pU1a42hhdiQ/ULk9HmZdWXnwP5JTHMiRF3OLJ+4pfx+DuZf1vLDS42BH18kED9TDcQTL
         ooEFnGDZ4l8k9GfFZs2ghoymnwD/U2YlvEc2KsAGEt79AyIpgBXLWBV2P6wuUzZrBpHo
         nGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739892176; x=1740496976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4rBn1loiHVRgqEEQSp4qIiIQysoefBUpVmMVONI/VM=;
        b=xECSNH9gPWiOA5F/EStoYundhWgtw4zWFSMeugw3zUjecE8ilTFfTeFs/GAwaIWCBb
         Tav6cl57cMh12YA06DqZudvH3N3DM0r3+7WfzppGlcREl4U2bhr9CMXQOKHTGq0+ab4K
         nhsGSqtZnbUhUJWrCNxFD0M5yVNaBvjCR9a8YB6m5j+laRKttwpIOZG2bvUEL+EdmSw4
         yDJIO6Y9anwqPmN/+8W5ies1BHo94BePJq74XCy3KcPlIciS4o3ad+PA8f3dmjmTdELh
         fjdQnZC4oQH5DEOdXscxWJOLINDuMdTojfMiJtPhwOuIegRfZpy9vhjUjysZf7pLVvhl
         xMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVb+cEQx66Fbeh92EG4r1TMqpe6/8o/P6yPVK1TSNYuAksjFaXjvTmuuA8h4NkPoPzoX3XZzhnUwt1n1Yz@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMsdf/p1fU0dB9rU7rRZ97ETc4h5sAUSwZ/AHfYkH5FXC1dtT
	IJzrbOmUkJHHMd8DH69YLvC1QnAqwDcAgsmEM+UqFRFlagUae1tw2HE/iB5i8h6mDVtQWDEg8XW
	0rg==
X-Google-Smtp-Source: AGHT+IHtk8QhNUJ5IVao0gvIDKE2j52eZP0sIqAgCjZecx7PvM8TzFSmR+acBjaj46uiYVes4srTDuaJU+E=
X-Received: from pfbjt23.prod.google.com ([2002:a05:6a00:91d7:b0:730:8a7b:24e0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:790b:b0:1ee:a914:1d64
 with SMTP id adf61e73a8af0-1eea9142045mr14137360637.28.1739892176009; Tue, 18
 Feb 2025 07:22:56 -0800 (PST)
Date: Tue, 18 Feb 2025 07:22:54 -0800
In-Reply-To: <469ee330-7736-4059-9e59-ec7b9a6d3c8b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210063227.41125-1-shivankg@amd.com> <20250210063227.41125-3-shivankg@amd.com>
 <469ee330-7736-4059-9e59-ec7b9a6d3c8b@suse.cz>
Message-ID: <Z7Slzs_4jZ2qkPAi@google.com>
Subject: Re: [RFC PATCH v4 2/3] mm/mempolicy: export memory policy symbols
From: Sean Christopherson <seanjc@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org, willy@infradead.org, 
	pbonzini@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	chao.gao@intel.com, ackerleytng@google.com, david@redhat.com, bharata@amd.com, 
	nikunj@amd.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 17, 2025, Vlastimil Babka wrote:
> On 2/10/25 07:32, Shivank Garg wrote:
> > Export memory policy related symbols needed by the KVM guest-memfd to
> > implement NUMA policy support.
> > 
> > These symbols are required to implement per-memory region NUMA policies
> > for guest memory, allowing VMMs to control guest memory placement across
> > NUMA nodes.
> > 
> > Signed-off-by: Shivank Garg <shivankg@amd.com>
> 
> I think we should use EXPORT_SYMBOL_GPL() these days.
> 
> Wasn't there also some way to limit the exports to KVM?

The infrastructure is still a WIP[1], though when that lands, I definitely plan
on tightening down the KVM-induced exports[2].

[1] https://lore.kernel.org/all/20241202145946.108093528@infradead.org
[2] https://lore.kernel.org/all/ZzJOoFFPjrzYzKir@google.com

