Return-Path: <linux-fsdevel+bounces-26199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADC1955930
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 19:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BEB282373
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC53155393;
	Sat, 17 Aug 2024 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZN53VIpY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BFAC133
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723916630; cv=none; b=acnryUaQkcUmA5f74imXFTdYNEJSQ2y90tHmx1npoWeZqs92flPuTydbiqmFOoHSSiy5Jl2VHyNPpeLq20Im5vMfrIta+P9x0nmXw3M1tl5F9C7NUx3Xe/1+b6s33ePFnJ5GYZ+TF6qcdtNARfqK6RHMtAgeOBAVzm+kfb3Wiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723916630; c=relaxed/simple;
	bh=tFLeE7NWu/I6y5GylW3zwSgwf1LeuPgfo4YnyW9PD5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gH/heZeDTwiI5OSFW7FaPvDz7+nvtNg+rCxQMCSqXb+X8FAsnUDT+ObTaBVkifESRi7j8gUys9b2iusUxQlkGKpNjvueHHN1Z+3r1WYdHr6o0NQ4pCZ+VSr/xBPH1kS9Z+igNgy/Xo4bF6q24M5ftTxcq8OqXy0msh5VzsFN7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZN53VIpY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so22220415e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723916626; x=1724521426; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BTapQ5ao4kba6wmh3n24QeKSX8dcmZzVFVPJRtGL8AI=;
        b=ZN53VIpY5YZhJpeTqaJE2bXsudOMaZDMbaGhISrhzjfl1j9tSreeZuLcjydUdpnF8j
         QoRG8VKbs+P4VjSXRs/IqrZTG4ZyDhEvxoNqzVJ73vyuuNVlRY76QgE6pkfKs65UYxMJ
         muR2ZoIm9QkpL794gHiuM1atX7yZS8zWK9r5gCeUx2GrzRu64jVjEfldgwtXY0L2Gg7A
         fNgFGkH5oD4qm8BQs+NIWD01cpv2SFEsxZG7+POc5Df8Sq88jdVdyYgoDLv3Ws490oLr
         wXvseHCuADNx4wb9rRRptp7TIbvI62+onSbB8zJPioYh4uecs2u7IWTP0pE6cCZMUCiH
         BCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723916626; x=1724521426;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTapQ5ao4kba6wmh3n24QeKSX8dcmZzVFVPJRtGL8AI=;
        b=Aa99S1B11N/GCDOhDWe0J3jRHFi4rq/T3omtPrAn0bpkEggo1PyC2iTYvlYdOPXhoH
         7+NAV8EA3mTFNVS+qh9yTSt2Un+jLDy8Pyiu3s+GuK13HZ7wBBXl8R/hJWOo3/c0HUeS
         Syuo6D1qXvgbGeHfApetJZLz3SmM1w7TIZWcVwV9KBfYS0xmA380xxKhCityAcb3Fc2J
         nrNaydPcBBvmCFjmRicgI3XAXs2sVFf6FkIU3/Axdm8viaHx5tSgQ4J2aeu2KQo+ysaz
         aUku9sTTpc7XYTl8NX702ZUq9/CcETcrCGjR7hAt5Kdo5K67OsLclF8rFseP9JnMZ+nN
         usEA==
X-Gm-Message-State: AOJu0YwJsP5lw/fWM98JhnYS11X3xp5wlmkH0pwBPMFhD5QH7V67NVJ1
	gnjcWAKeDHj72ne2EBft1SwYzNURhoe03LosimGJgy9u9Rep/yyOF+/Hzs5622w=
X-Google-Smtp-Source: AGHT+IFP/BhzT8Bp1jT37BqPZf7xZvBOOeFHjxbOh9LNc8IO6RlPhw/xXPDiJLgWDALa0dEYG7Iu6g==
X-Received: by 2002:a5d:4e4e:0:b0:360:7887:31ae with SMTP id ffacd0b85a97d-3719468d263mr5279478f8f.54.1723916626360;
        Sat, 17 Aug 2024 10:43:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aab44sm6305239f8f.91.2024.08.17.10.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 10:43:45 -0700 (PDT)
Date: Sat, 17 Aug 2024 20:43:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] fs: Allow statmount() in foreign mount namespace
Message-ID: <e7d78aa3-a6fc-4bf8-bec2-2a672759b392@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Christian Brauner,

Commit 71aacb4c8c3d ("fs: Allow statmount() in foreign mount
namespace") from Jun 24, 2024 (linux-next), leads to the following
Smatch static checker warning:

	fs/namespace.c:5350 __do_sys_statmount()
	error: 'ns' dereferencing possible ERR_PTR()

fs/namespace.c
  5314  SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
  5315                  struct statmount __user *, buf, size_t, bufsize,
  5316                  unsigned int, flags)
  5317  {
  5318          struct mnt_namespace *ns __free(mnt_ns_release) = NULL;
  5319          struct kstatmount *ks __free(kfree) = NULL;
  5320          struct mnt_id_req kreq;
  5321          /* We currently support retrieval of 3 strings. */
  5322          size_t seq_size = 3 * PATH_MAX;
  5323          int ret;
  5324  
  5325          if (flags)
  5326                  return -EINVAL;
  5327  
  5328          ret = copy_mnt_id_req(req, &kreq);

Should copy_mnt_id_req() ensure that kreq->mnt_ns_id is non-zero the same as
->mnt_id?

  5329          if (ret)
  5330                  return ret;
  5331  
  5332          ns = grab_requested_mnt_ns(&kreq);
  5333          if (!ns)
  5334                  return -ENOENT;

The grab_requested_mnt_ns() function returns a mix of error pointers and NULL.

  5335  
  5336          if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&

If kreq.mnt_ns_id is non-zero grab_requested_mnt_ns() can only return NULL so
this ns dereference is fine.

  5337              !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
                                        ^^^^^^^^^^^
So this is fine.

  5338                  return -ENOENT;
  5339  
  5340          ks = kmalloc(sizeof(*ks), GFP_KERNEL_ACCOUNT);
  5341          if (!ks)
  5342                  return -ENOMEM;
  5343  
  5344  retry:
  5345          ret = prepare_kstatmount(ks, &kreq, buf, bufsize, seq_size);
  5346          if (ret)
  5347                  return ret;
  5348  
  5349          scoped_guard(rwsem_read, &namespace_sem)
  5350                  ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns);
                                                                            ^^
Smatch warning tirggered here.  This dereference will crash inside the
mnt_find_id_at() function, called from lookup_mnt_in_ns().

  5351  
  5352          if (!ret)
  5353                  ret = copy_statmount_to_user(ks);
  5354          kvfree(ks->seq.buf);
  5355          if (retry_statmount(ret, &seq_size))
  5356                  goto retry;
  5357          return ret;
  5358  }

regards,
dan carpenter

