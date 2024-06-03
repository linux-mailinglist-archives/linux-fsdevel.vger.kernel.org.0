Return-Path: <linux-fsdevel+bounces-20837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C16588D84E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 16:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B983B246A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF3612E1F9;
	Mon,  3 Jun 2024 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4zGbTt/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75012E1EE;
	Mon,  3 Jun 2024 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424694; cv=none; b=cw8SsQjyGn1ZhYghiNpnNL7wKDUpblCZYjExOqVlxpMNp6nA5x6l5DHG6ynCW72LB7f1ykdNCMtFF7eLRHcMLZPh6z4aAJVXvDn078cWt+sZcTUxeBZ0i70LFtaOysZtxrOtIFnscVG5bzoapksKsngOhn0z6SMhLSLcBweMW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424694; c=relaxed/simple;
	bh=FVnGwVIFI95WxsUhiUDYkKdJpAAeSig8g2nYFSb5Tp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m05bdf0XMzh0Lej96XFEmQIa+qAth3mzQkKVq8sYB2/WiLzD42oL2u10Z4PEHVgFfURO5SQ1Gj3kIjqHe3bC+hzaiel4zbujo4ctj1Jpmg1+kooWvDpIRS5nO89Qms8++yhlFC5iwohN1CnY6gfWwZ9tWUvBLq8H3/7yad14ttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4zGbTt/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so20287961fa.0;
        Mon, 03 Jun 2024 07:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717424691; x=1718029491; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vLXycQcuya3XwERES41uCRyU6WafUiXp+BhlyiompBA=;
        b=H4zGbTt/FWTStL0cZsfnww0PYagOtrEFOyUaKAHt/IFljOqtyBGenmAQITDyxpkzgh
         BrsXvBXSb04PWHtQ3nxYhXK07SH3he7/bATUFJlXw5fg53SwBiBYn3MQMlSQhfWsinmo
         DXaiRczL41FpDoYYoNRs06U5THjbFAodQrXEJ+wPbWIGC/b/te2go7We0uBXinEK0IfT
         8ClbtPOu7jJLSzigbSZzMLzRWfapiMEkvBfhS0vsv/PJwET3k7hsZR8OPwAAGu/U4NSc
         vzbp3Dz12/7TVngmesT2hG7FMtNflJTSnuoW6ct7qIQEtyNbl6T9UL6W3Y4XNcORaStY
         9ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717424691; x=1718029491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLXycQcuya3XwERES41uCRyU6WafUiXp+BhlyiompBA=;
        b=lF9HqI3ioYTW2H0o5v6GKJ6c4RmzuMn8JHNkbtgxfX23fKwD0dcPjMqf2Cj2SE8zWC
         S25EXdjSrl5BMLEN3Poe+O9DckQrNM4bCcYATTIJ/yHN0sKwz3WUh945TdLbMnrHIZIP
         EcAsrIKQNOc3Cc/Y+u0rJBQkWk88ufGteNZhXLjCkWIYedYBPqtUw5aHE5zGQ7G3pIg8
         T5WhVHD6krwK7tvep30telGW+ZmkCOol3ThJ1nMTz1k58R94veQI/IZibm+Tf+gCLsIY
         qDzfaqOTMVyXGFmciqiUK65mu6H36jeDSVKqGffLHaLMh/bLdtDi82INzGhw3AKn+6Qa
         /pdg==
X-Forwarded-Encrypted: i=1; AJvYcCUz5EqKAcp7oDaXi0ytntTtbEVVb97xPMiq9aiHzAAIqSDcybI8/VSJRH8+H2van04kZk2rv6CC6B9YUYwjbgrtIrkS14n8tWvuS7OQ5U4xY/SK+UlSIiXpaoicV/dnrLrsAbnlPA8m7cFc9qS4ww14hmczV1X0hbNw9vJ32nMGX9aa4qUnNcUXjGOs0A==
X-Gm-Message-State: AOJu0YycAxJWPByvsBkdNWkLd/GOTm7H0K1+7ce24Aji3q+FR9S2o0sn
	yS5FyCLCG7d6rFXMCqTlQ+HLhWGKIjh1CdOq15oot5U97wEHidE=
X-Google-Smtp-Source: AGHT+IFwA8NgarD6Bgi5CLSLnkfaUokrvVuBDxZzTEAzfDPyYApWXen3F8SVfPFgta7Jm3baxvkrOA==
X-Received: by 2002:a2e:9ec6:0:b0:2e6:935f:b6d3 with SMTP id 38308e7fff4ca-2ea9510e721mr77688041fa.14.1717424690465;
        Mon, 03 Jun 2024 07:24:50 -0700 (PDT)
Received: from p183 ([46.53.249.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68ce1e4462sm306750366b.197.2024.06.03.07.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 07:24:49 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:24:47 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Amer Al Shanawany <amer.shanawany@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] selftests: proc: remove unreached code and fix build
 warning
Message-ID: <14f55053-2ff8-4086-8aac-b8ee2d50a427@p183>
References: <202404010211.ygidvMwa-lkp@intel.com>
 <20240603124220.33778-1-amer.shanawany@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240603124220.33778-1-amer.shanawany@gmail.com>

On Mon, Jun 03, 2024 at 02:42:20PM +0200, Amer Al Shanawany wrote:
> fix the following warning:
> proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’

> --- a/tools/testing/selftests/proc/proc-empty-vm.c
> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -381,9 +381,6 @@ static int test_proc_pid_statm(pid_t pid)

> -	if (0) {
> -		write(1, buf, rv);
> -	}

no thanks

