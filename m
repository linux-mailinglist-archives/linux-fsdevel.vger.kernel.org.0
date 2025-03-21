Return-Path: <linux-fsdevel+bounces-44744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B209CA6C4C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 22:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339D13B829D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A8231A2B;
	Fri, 21 Mar 2025 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zabbo.net header.i=@zabbo.net header.b="X23WBq3x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979FB2AF1B
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591105; cv=none; b=nXgRXOjg/wLh5qqMnqksL3Uvj/KmcdazAFPgjhwvmTQgYSiU13jJvuQKd4wY1t0JvvXmZ0ZwSYifCqUqz9xnOIs+j2YvqbRy3n4TumexXjxJwaTY2DlNNxSrWHdgqq1HS1iF8j8C4bwPTThCNlxOzldZhrtdXg5L585pPXZf/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591105; c=relaxed/simple;
	bh=bIYuo8dCHdpb3oT2mPOzlmhHNrTS4RFBv7ogjQh8ZSE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r6y1n/mXykGwacCTRarjJ5miAKiYffGIiWWkowNzEYWb9C3zyDAxL2jep6JiFGBDUh6p4zhGQga0YjpD9O+aSqxbc/bWYnUkjs/VgDZ/FVDorrDhLImZZ2WiZuZNKy+e3/dXRHU001elG8hX2zMBerPTpeCxEjECynLfjxvJsrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zabbo.net; spf=pass smtp.mailfrom=zabbo.net; dkim=pass (1024-bit key) header.d=zabbo.net header.i=@zabbo.net header.b=X23WBq3x; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zabbo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zabbo.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223f4c06e9fso41146095ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zabbo.net; s=google; t=1742591102; x=1743195902; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZcKiwzh7pWnMXNw7hIf08PVT0DZh1CX+ynh4UDK6K4=;
        b=X23WBq3xTXt2XjpUqqIWrnSUsDOQCxzKXLQeOCUSwnMVlVUXzw13ZW5LS6lW5gUE+T
         lmXzVvBas6XYSE61fy0oENt7u+qRMyLXUPj+/elgYfBLds6DpEjiY/WJKpC79uPi4RFq
         zgKUOLO2/fWDYSaOXvyvZ9duiHnmvQT8bbAUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591102; x=1743195902;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZcKiwzh7pWnMXNw7hIf08PVT0DZh1CX+ynh4UDK6K4=;
        b=JFHe3F77nxzf8exbUzXXGN5oZj9iQ5mRriGx9+FDl/7enHc+1MDQi6ohJGNIEEK3Nw
         bB5ihlzxg3PK88j0GjGbQztX3M1P5luSoK2T58fMLSLrLO1yGOAlTlUPq/A9FsO+fn2i
         7cgJPF1nYR7wpcLIKBCZmjwlJWeUjOjcGdAufMwJTRPUbS4jmNC2dmAfk5Ou/uRE6Xgm
         E6p6q1cjL7EOB+VEgeEELg6UjH4a3Oi60P3jsMEes9itG9UOn8M+M2YdlAZUJbvY9gIQ
         DrmnVeOySpD5g2jPkiNNlyCos8hv1QF1+XjOfcbRxnmvjIXVuVuHkhWnnMCwxZAzxPmn
         8A/A==
X-Gm-Message-State: AOJu0YxafH5UZD+DKvf/2VFVh/6/iG9VCQpq3lJU9beNNx6VDTWK44q0
	Id3G+fHn0X/eDSikp08LTnpPIIvNfToW9p6qb/NKmZLx52Mt2mH4rAsEde82OzGHDXRH+FIrKDY
	Y
X-Gm-Gg: ASbGncvV9O0yRyA7nNYd4P0W01kYw2gVQPJCV++hKWgeG7lBXYPrJ4dtCjtVEbd0NwQ
	LIiqG3RRUEmUHWmsKWm2A2z+rHMMrJvmrIFSqlTjx9rToSanL0+znA38FSxEaricWyhRbkzV6CW
	sY/v3m2lDTrgmwbzU4/tyiQciRLLHDqXT/5lPDKc9r4cAgQEPYZ0KGgquQSaIfLsYY89ISxgySV
	+ltXC13WSUMjp8eVNm264XABpJxOoEuB6zFp++/lm5gdS5jBJIRDc9W8q7W7upeyoURR4J98O+Y
	soPb4hip13xGFdVDiBcCBjsjKRRhg9uj/I5HyFPXOASJvmU=
X-Google-Smtp-Source: AGHT+IFLmy74O9vGnhF+e4ecqJFvKNuDsuftMwIG+XXYGYvBOAT8AlxOqWl/WfBcvL7SHfA2EDVjmw==
X-Received: by 2002:a17:902:fc45:b0:224:3d:2ffd with SMTP id d9443c01a7336-2265e743d42mr143860945ad.17.1742591102108;
        Fri, 21 Mar 2025 14:05:02 -0700 (PDT)
Received: from localhost.localdomain ([50.39.133.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73906157f6bsm2566533b3a.138.2025.03.21.14.05.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:05:01 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:05:00 -0700
From: Zach Brown <zab@zabbo.net>
To: linux-fsdevel@vger.kernel.org
Subject: [LFS/MM/BPF TOPIC] discussing ngnfs
Message-ID: <20250321210500.GA317758@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi gang,

On Wednesday Ric and I will be leading a discussion of ngnfs.  It's a
ditributed file system build around a coherent distributed block store.
The intent is very much to engage earlier in the development cycle
rather than later, so any and all topics are welcome!

I talked about a piece of it recently at FOSDEM:

  https://fosdem.org/2025/schedule/event/fosdem-2025-5471-ngnfs-a-distributed-file-system-using-block-granular-consistency/

And we're currently focusing on standing up the userspace pieces to
validate the design:

  https://git.infradead.org/?p=users/zab/ngnfs-progs.git
  https://lists.infradead.org/pipermail/ngnfs-devel/

Looking forward to seeing everyone,

- z

