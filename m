Return-Path: <linux-fsdevel+bounces-38351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1344A001CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 00:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91F83A45D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 23:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC81BD9D5;
	Thu,  2 Jan 2025 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EeZ2fAGs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97991C36
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860781; cv=none; b=dVSgsI4gKMQDYoP6Nf9XxghcVYkVwEQ3RFBlX+QJMPkxrc/zHZmQveyT97O3oLN0GvJaBLri4n409qg3Mdj879+XhwBduuHCqV228njIdRUsbXRg6MrCt7EfceSwJkRdTDbxNJdAw8/PUmrN+no1b0bKNRzZerM8Xc3Kf6pDdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860781; c=relaxed/simple;
	bh=WHoFZVu9/NbFhYk/LG7oSzL9kGz8cogN15++JUcpMAg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S0ZJ+SRfpI+P09l9vdmjEw7ApCoFfwv/I6X3Y9CZ5UBEsLiq6xTGtZyfeo1xN2jXQmiABb6d/fF5lp05YDUe8z2GXa3aDCGHWJgCIDMSWKyMhSzNRmcABRPNCRj8qcFmW304+pSrq3m7SQ/fYz5Rt2Qi80AzS3ERNoX91yQ1EAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EeZ2fAGs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so16414970a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2025 15:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735860778; x=1736465578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QDuU3J1IGGphn0zaLirngh/aUSWdaIEND3bK3n59yFo=;
        b=EeZ2fAGsMscWAcIOUVKzq3+NwzXISn0D59dJhQDUv4eSXA48Enbaywk/cHY0UWqfcJ
         NA2Scru8DhNvAqetgUfXPwoNI1cp7/BR1Fwckkm+9v3K1/G/Q4WV9JCxKyQTMarSD5CD
         zyAq2T8KVDb4HM9waQWBfOWo7o50Qpb0NNlVwsqsa2YwBjp9oTx7ACyS88zUa7pRMg8+
         DkXdK13ItmBg8pULXy0uwE6J2mcG8gPvjBTnQZYC/du7k/YLZhoKKs6eN7BmPdCD/BPr
         oeD7ITtjGxw9/NDqtdluK5TPBwDIsvUSulCAzrZeBcpNxeY/aNUuKbmdN0EQgq/9L8hO
         b4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735860778; x=1736465578;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDuU3J1IGGphn0zaLirngh/aUSWdaIEND3bK3n59yFo=;
        b=OomSgOslbrAPRQPF10hIJK+vakaIRcbeLWMl8uSVCnb1WFXo5RQGlj3cPe4f4Vbmf2
         UsVinpfTr5Zfnb7GQIDJIs7KIAAW0Mnw9rU0aXrhScyrzU9Juafi0qsDC909iNNgDHUt
         XdqsANWMbxY8ZAatAFYye/+b+P5fpHEC4Bme5teJNGbUbn8Il8XPqRb3J55+1XPWiili
         /k0CFOZqZDconsgM8Re13Tf4GM2MtHDLdzfyKPAJukQ3XOq5Yq+SQf4JQRRTjq0CFX6F
         89lvJkq5ieBlbznvFOJW9hczHXIcyUsJL2rdhBdeaLOqnT6tdWz4CbgESG8j62tZBXMH
         VJxw==
X-Forwarded-Encrypted: i=1; AJvYcCVP//1iSVy/Fx0FFTIEIhT8PQLPsb090QGqb9inv5Vje8iuQvzeYRXNBkBapFj7Rydk2MKE8VIvesg/xDHx@vger.kernel.org
X-Gm-Message-State: AOJu0YzyXvkszOgsKDmPmPGGM5a4UGvSfIib/XwfM3vb2QRed2xoZKqk
	IAFNomWcMrUoNif4EL+gRuJ7qZ3FOhHsqtpts3uuLLfYg992NH4n5VSijG+QqNNVaYS5YJDw891
	DUEOF8o0PsgL8oLPdtommap8zDdaHxujtdA==
X-Google-Smtp-Source: AGHT+IG7y+IwwDV/Tqo322/ozip7aZe+2uc1Qx4485ddX1VhXCnLu1xgDDARozVocD5+sVJXjpD1g9odrGjfFfvYjZV0OA==
X-Received: from pfwy1.prod.google.com ([2002:a05:6a00:1c81:b0:727:3a40:52d7])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1144:b0:729:597:4f97 with SMTP id d2e1a72fcca58-72abde828c1mr74507334b3a.20.1735860778070;
 Thu, 02 Jan 2025 15:32:58 -0800 (PST)
Date: Thu,  2 Jan 2025 15:32:49 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250102233255.1180524-1-isaacmanjarres@google.com>
Subject: [RFC PATCH RESEND v2 0/2] Add file seal to prevent future exec mappings
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: surenb@google.com, kaleshsingh@google.com, jstultz@google.com, 
	aliceryhl@google.com, jeffxu@google.com, kees@kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

* Resending because I accidentally forgot to include Lorenzo in the
  "to" list.

Android uses the ashmem driver [1] for creating shared memory regions
between processes. The ashmem driver exposes an ioctl command for
processes to restrict the permissions an ashmem buffer can be mapped
with.

Buffers are created with the ability to be mapped as readable, writable,
and executable. Processes remove the ability to map some ashmem buffers
as executable to ensure that those buffers cannot be used to inject
malicious code for another process to run. Other buffers retain their
ability to be mapped as executable, as these buffers can be used for
just-in-time (JIT) compilation. So there is a need to be able to remove
the ability to map a buffer as executable on a per-buffer basis.

Android is currently trying to migrate towards replacing its ashmem
driver usage with memfd. Part of the transition involved introducing a
library that serves to abstract away how shared memory regions are
allocated (i.e. ashmem vs memfd). This allows clients to use a single
interface for restricting how a buffer can be mapped without having to
worry about how it is handled for ashmem (through the ioctl
command mentioned earlier) or memfd (through file seals).

While memfd has support for preventing buffers from being mapped as
writable beyond a certain point in time (thanks to
F_SEAL_FUTURE_WRITE), it does not have a similar interface to prevent
buffers from being mapped as executable beyond a certain point.
However, that could be implemented as a file seal (F_SEAL_FUTURE_EXEC)
which works similarly to F_SEAL_FUTURE_WRITE.

F_SEAL_FUTURE_WRITE was chosen as a template for how this new seal
should behave, instead of F_SEAL_WRITE, for the following reasons:

1. Having the new seal behave like F_SEAL_FUTURE_WRITE matches the
   behavior that was present with ashmem. This aids in seamlessly
   transitioning clients away from ashmem to memfd.

2. Making the new seal behave like F_SEAL_WRITE would mean that no
   mappings that could become executable in the future (i.e. via
   mprotect()) can exist when the seal is applied. However, there are
   known cases (e.g. CursorWindow [2]) where restrictions are applied
   on how a buffer can be mapped after a mapping has already been made.
   That mapping may have VM_MAYEXEC set, which would not allow the seal
   to be applied successfully.

Therefore, the F_SEAL_FUTURE_EXEC seal was designed to have the same
semantics as F_SEAL_FUTURE_WRITE.

Note: this series depends on Lorenzo's work [3], [4], [5] from Andrew
Morton's mm-unstable branch [6], which reworks memfd's file seal checks,
allowing for newer file seals to be implemented in a cleaner fashion.

Changes from v1 ==> v2:

- Changed the return code to be -EPERM instead of -EACCES when
  attempting to map an exec sealed file with PROT_EXEC to align
  to mmap()'s man page. Thank you Kalesh Singh for spotting this!

- Rebased on top of Lorenzo's work to cleanup memfd file seal checks in
  mmap() ([3], [4], and [5]). Thank you for this Lorenzo!

- Changed to deny PROT_EXEC mappings only if the mapping is shared,
  instead of for both shared and private mappings, after discussing
  this with Lorenzo.

Opens:

- Lorenzo brought up that this patch may negatively impact the usage of
  MFD_NOEXEC_SCOPE_NOEXEC_ENFORCED [7]. However, it is not clear to me
  why that is the case. At the moment, my intent is for the executable
  permissions of the file to be disjoint from the ability to create
  executable mappings.

Links:

[1] https://cs.android.com/android/kernel/superproject/+/common-android-mainline:common/drivers/staging/android/ashmem.c
[2] https://developer.android.com/reference/android/database/CursorWindow
[3] https://lore.kernel.org/all/cover.1732804776.git.lorenzo.stoakes@oracle.com/
[4] https://lkml.kernel.org/r/20241206212846.210835-1-lorenzo.stoakes@oracle.com
[5] https://lkml.kernel.org/r/7dee6c5d-480b-4c24-b98e-6fa47dbd8a23@lucifer.local
[6] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/?h=mm-unstable
[7] https://lore.kernel.org/all/3a53b154-1e46-45fb-a559-65afa7a8a788@lucifer.local/

Links to previous versions:

v1: https://lore.kernel.org/all/20241206010930.3871336-1-isaacmanjarres@google.com/

Isaac J. Manjarres (2):
  mm/memfd: Add support for F_SEAL_FUTURE_EXEC to memfd
  selftests/memfd: Add tests for F_SEAL_FUTURE_EXEC

 include/uapi/linux/fcntl.h                 |  1 +
 mm/memfd.c                                 | 39 ++++++++++-
 tools/testing/selftests/memfd/memfd_test.c | 79 ++++++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


