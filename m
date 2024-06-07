Return-Path: <linux-fsdevel+bounces-21260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758A9008C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B81C21326
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC598197A97;
	Fri,  7 Jun 2024 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdNzeCOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C09194AC2;
	Fri,  7 Jun 2024 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773940; cv=none; b=u//SxNFFjEs2MC9c5diOFsHW8Yk6o3L0ZiYkIW215n3aTYKdH+tT38XSne6z6PiU3lbQmJu6k5hXUJCg/h0wvE8YkbjFAJw1Q9VKGQKRd+F1CNop2nqHj6/7JLMZoyXNb0Hhb4gNo1cje+Tkk5XDZa5fP8VS/z337Jr9pDrOxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773940; c=relaxed/simple;
	bh=wwNKMN84Hed198AibGQVitq1sUiDKwI0ufHAfH0xtRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O70pmY4Aed9qTybJBr8gKrQNiqQrVrOwmBh8IOScAlpvppxzLu9WiredOp4hNAtkdgp7hLutYQX4HkLkpXqkrfZKp5t2XNckksPyapPkV/fH4G1EzTaKBLBY2CKZjcFlgs8ZvChNkiGJXT8AVCww7S/oUkytM6G/zF0v9uuLm+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdNzeCOP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4217926991fso1462915e9.3;
        Fri, 07 Jun 2024 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717773937; x=1718378737; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TuyYIFFv4coVUtE6SznjWB/DFY1udQE67Js2ht0hux8=;
        b=UdNzeCOPzhRSZAbhu6G1OqWdde3sFsNGFRRktQNeI5JOy0uptzioOz9ePbxE7ljqx5
         rz9VGV0zj9TjRIUfLh+z4+BSAWhOrbG33qo+36wV8YM0YIuiR9apsY480H5qDgZzPCeq
         vlq/oaNqk+a4HAlymuA1xtMIu4xbcSJJw3yJObtGX6xRl11ifG63F7oZz9tzgPWsbWcZ
         Y4wTBOX+7iFXwNBgNmz/kGpvm7kzIq52j9WeK3/RHOvjiCS81QwcRSZVQhZkd2UHzf9i
         I4xK5z1gt0s+aQ7e9ujSYMhdciYIIuOl2LQO2BZi8v1oKyH9Ey/Y3drlgrvKWktrLhcp
         kG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717773937; x=1718378737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuyYIFFv4coVUtE6SznjWB/DFY1udQE67Js2ht0hux8=;
        b=biWZZaACVRga2Q+jT1Y2gS0oxyUOxuIqD++ILFAWxg/Ngak8NaX/dVjhPcjn4vMhQ3
         NKu5xF758KXcYMdT0E9gXxSi0u8jeSSghwgerN2leT4emRbaGt72XlzaAQTZ/Q0GlIrz
         2N/Blam9x4Nz5OTHjDwqLf4pUyGD9nRFgOGh9iT/8q4f98wRNLl5B/P8/RZv0xyy/srY
         Xy+9Q9IXlToSQ/Okhcmqi2k9OK5XofNekzvmyDTTqiftnfV54Fqexr91PpaAPApAp3jF
         fzuql9K2poTk7PiuPKeTx6nv1lfHV1sCOK6yShpDL1d72H+9BGHpQ3YEEuLJgLjkh+NE
         C1SA==
X-Forwarded-Encrypted: i=1; AJvYcCUv5ZJpLXF3QeljuNyyBh/CmeL6MBVAdteQ33H6SYhiA75hoABpuhXdHEM+AziKR1Uwr3J6NXpYLvI5XnLGlBdDUSKooMTlrzZQ2SGf0AvzY72ZLaozZfMXFrUHR//BC5STIZbvUPRxXMHDnZyaaYCYRtf++fdYMYenVLrqDu6n/9raSSce2pjK8obB/w==
X-Gm-Message-State: AOJu0YzuYQH5btcVWfHAnuqZwPilWYs1cSrNQZ/5RMJuTpgZzu5JaFAk
	hIRj8w5rYReW/oFajhxLNbmxEI2wF4Sx7ynWtVOB3l0UPNSeOxI=
X-Google-Smtp-Source: AGHT+IGXtYC4WLdTBer9j1GZeuSmKlkiVkz9fUSgbMoshOxZmCikz3Ij32lopCDxzZ9ZKjioE5UHUA==
X-Received: by 2002:a05:600c:3c94:b0:41a:b54a:9ad8 with SMTP id 5b1f17b1804b1-4216499c726mr30425595e9.0.1717773936724;
        Fri, 07 Jun 2024 08:25:36 -0700 (PDT)
Received: from p183 ([46.53.249.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0bdce051sm1017515f8f.75.2024.06.07.08.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 08:25:36 -0700 (PDT)
Date: Fri, 7 Jun 2024 18:25:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Amer Al Shanawany <amer.shanawany@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] selftests: proc: remove unreached code and fix build
 warning
Message-ID: <eb9b2d6e-91eb-4fdc-b352-b3d0c290da2f@p183>
References: <202404010211.ygidvMwa-lkp@intel.com>
 <20240603124220.33778-1-amer.shanawany@gmail.com>
 <14f55053-2ff8-4086-8aac-b8ee2d50a427@p183>
 <20240604202531.5d559ec4daed484a7a23592c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604202531.5d559ec4daed484a7a23592c@linux-foundation.org>

On Tue, Jun 04, 2024 at 08:25:31PM -0700, Andrew Morton wrote:
> On Mon, 3 Jun 2024 17:24:47 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > On Mon, Jun 03, 2024 at 02:42:20PM +0200, Amer Al Shanawany wrote:
> > > fix the following warning:
> > > proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’
> > 
> > > --- a/tools/testing/selftests/proc/proc-empty-vm.c
> > > +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> > > @@ -381,9 +381,6 @@ static int test_proc_pid_statm(pid_t pid)
> > 
> > > -	if (0) {
> > > -		write(1, buf, rv);
> > > -	}
> > 
> > no thanks
> 
> Why not?
> 
> Why does that code exist anyway?  It at least needs a comment.

OK, whatever.

If test fails, it better record buggy output somewhere (to coredump or to terminal).

