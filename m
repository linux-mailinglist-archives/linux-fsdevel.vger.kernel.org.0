Return-Path: <linux-fsdevel+bounces-28276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E3E968DED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 20:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A10E1C2238E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61CD19CC34;
	Mon,  2 Sep 2024 18:54:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5511A3A93;
	Mon,  2 Sep 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303275; cv=none; b=bCXMvJDjr1nwGw6pfKYwmmYnPdIwMR/EZOWBF/JKRlKUE6Yw1lnbMP4dX4MAnXKKF4YwryjS/VL/MMVNIjEWjWlQAhFTg5mnjkUfTNhRRvwQQpqNSIjJsCh0xwT0baY/xO/8zRXZ8L9BzQ4VG897BeXG1qRTg5Awg05+xLWZ300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303275; c=relaxed/simple;
	bh=gTSzzy8qy3//EGLWo3rinOcx/5vjdLEbDiuK+VMVDls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuTjzeRLAzclKmrrqxFe0CwryZyaUFMiehMcE1DHHd5Zhz2r0h0e/x5ud2gNs+J7sY+XIOQYfCird7ALmj3iyJJrYV7cGEJe+eHxOzT/UZ9K/vSk4fbmB/FWQVarYgpb5nfW62OTc0aLnnSAPy38MSFxeL7YGxTCEeu0r1XpDRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B088C4CEC2;
	Mon,  2 Sep 2024 18:54:27 +0000 (UTC)
Date: Mon, 2 Sep 2024 19:54:25 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 19/39] arm64/mm: Handle GCS data aborts
Message-ID: <ZtYJ4SUDLxrjDDBX@arm.com>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
 <20240829-arm64-gcs-v12-19-42fec947436a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-arm64-gcs-v12-19-42fec947436a@kernel.org>

On Thu, Aug 29, 2024 at 12:27:35AM +0100, Mark Brown wrote:
> All GCS operations at EL0 must happen on a page which is marked as
> having UnprivGCS access, including read operations.  If a GCS operation
> attempts to access a page without this then it will generate a data
> abort with the GCS bit set in ESR_EL1.ISS2.
> 
> EL0 may validly generate such faults, for example due to copy on write
> which will cause the GCS data to be stored in a read only page with no
> GCS permissions until the actual copy happens.  Since UnprivGCS allows
> both reads and writes to the GCS (though only through GCS operations) we
> need to ensure that the memory management subsystem handles GCS accesses
> as writes at all times.  Do this by adding FAULT_FLAG_WRITE to any GCS
> page faults, adding handling to ensure that invalid cases are identfied
> as such early so the memory management core does not think they will
> succeed.  The core cannot distinguish between VMAs which are generally
> writeable and VMAs which are only writeable through GCS operations.
> 
> EL1 may validly write to EL0 GCS for management purposes (eg, while
> initialising with cap tokens).
> 
> We also report any GCS faults in VMAs not marked as part of a GCS as
> access violations, causing a fault to be delivered to userspace if it
> attempts to do GCS operations outside a GCS.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

