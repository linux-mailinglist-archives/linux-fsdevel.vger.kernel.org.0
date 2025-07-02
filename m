Return-Path: <linux-fsdevel+bounces-53670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D98AF5BAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3CC4E81A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978B630AAB6;
	Wed,  2 Jul 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai9SII01"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4063093A3;
	Wed,  2 Jul 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467906; cv=none; b=eAQhzZ7jaGUoGhMdC1KAelbPy70dSHpC3LaFlkNGphfYVCQQzHzSCJzxZ2TIt+f169GdWQ0xbythSCNav8H4mMIVjMLlp+3DHmVtPUVjOH6lXwsnQWneN+bWuq7RWc2GpTH3htJu7IoWZvHWWHOhRd9WS4TcWVLNSlEBknoexmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467906; c=relaxed/simple;
	bh=QaJ6oz0GkwKizYXM3ML6bUNDwcopvdmWHVZn466HqjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaGa8lipY7J522s5/NAIOIbbuMylt9caDWWZkYUWztWb2dsTHBgNioS7Hyqp1m5yZevjzxM6CFMI0uRXaicg8KMC7kaoffI0fFa+oPLHCPh1RNw5Qr1aeArRbhdAOrnJiOPz7YXyK43/qRiIjEcfA1DUOqB1t5vUyZuGN+JgWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai9SII01; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235f9ea8d08so63894075ad.1;
        Wed, 02 Jul 2025 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751467904; x=1752072704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBca6/tX4UaiNS88cVzn9ejTz7Ui0nOCiCDYDy5kH/4=;
        b=Ai9SII01BEx6xE4H8rRwHxto+4km2j5rQKKxHGB4eoph25WOpcQjohdag1yOd+b5ik
         RKhC3ss1B1Qw+aiayfZEmwwbg96r4Nr1s7A+5uUtlxEEYwr7uHIYHZCfr1KE1wiWWnA3
         bxAxjapWIxIBxNT4IbHokXvwTK9PLA6MVFe21jyiqsoshMDXy9Dp8DK7dlXnXAHZOSWk
         lKNrdkhJGCFJarzt12jzFrBufZb5QlR1xx9g/bEGv2XFtQ/GzTa+fjf8rao+GORClHWh
         dNOiHoAHWm4btaMAS8V8njThyl03/fQTtf5Bh5PlEPNG8LCnkDkLGGdNPZ/37f9/j1y/
         84Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751467904; x=1752072704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qBca6/tX4UaiNS88cVzn9ejTz7Ui0nOCiCDYDy5kH/4=;
        b=YvlwhyKldXONsVpeXd1dz+kUrVcw43AnWA6u6Ly74yVjk9rqms1SNljEf/z50lfqxI
         +LPaC2wEVnfXKHGeFDCSf0NnY1Z4PGBKEDtQS41LzhxRB09DskioZxbnOc+FwyY8mfT6
         o52hYJpaaoWf4cUxQuFBvgC8iBFYDvQCED4YD+FiCjTRZioFLnLhGoL8GHMhYYu+yBKF
         d6g++HbeR2wvGKvfUSQ0pWvxMbL1hErRCQufFdK63e72m7egNLuIi9WBKqocpXvRHaIK
         SxWfA/6WAB+p8p4n9FO8+P7VSyPzs6BO7/8K8UNsv0r8tdYoMaaMBpuI3EINjjYJDMam
         iiwg==
X-Forwarded-Encrypted: i=1; AJvYcCUSCQgrA1OOASehGNHtp0uxGHSY1CJmllheUDwe+GDutNAXPZufzERU/yQ1jMjCGfpdx1pE+0Sf2J2vqg==@vger.kernel.org, AJvYcCUmXya3in2/B/11OjmWxkalxIhFJzynhIXZDD1fV1XWVhUf5WsioaiPs3tJwSF7DxrpFK/Il7BUtDpnegWprQ==@vger.kernel.org, AJvYcCUzVxbePPCUEGxjOFnZjGgw08on9hX58kqITwBMcI7pASven2JwzrENYVsHL43rHtvVlEXLAdOUW8/UAX/i@vger.kernel.org, AJvYcCVNnxZt+XgJZMyKyFA2x7GL94OJwEHJoZl1h4zkUPpaRZKj90PFie1pYB/U7zH6BGiUhpmhXpP4wM1ZRw==@vger.kernel.org, AJvYcCWnQG7MuftVijR4WwwzOUjibb/Xr3SZMwifgF9bA6q//j0uJcV2dxiJTM7Su85O2XwjHwPWxRQ8RcU1@vger.kernel.org
X-Gm-Message-State: AOJu0YzYO4GOOcLA5L3AFEVoQsPaoGvFYa7USxSmFvBfCLYbFS2vJj6W
	cPLkfWwnKu1WcbleA5s8KmHMWLNqhYX8eRnOn+94TmlaUj0mxtdcZ1Wd
X-Gm-Gg: ASbGnctGYf6BY2iRl3l7sBL3Zu3bI10jxGywEPtFrdG4/dVblgZNmxyEdZfyVvPJFJY
	2DLmp0IT3gX7Wbr3Y2Y9hHQDZIGsbNx0qIDdEoochQuvO1yuFiVknoBprjTwjWjKqUyrLn3Zo+6
	3Wm5v3rXbEvWbyZtnYlNke4z9MjFJqhX3Pe+QVjFGX8vZW9VqL0N9XX37n2Ub45k1rFuOkJmIOR
	vbPdjyVX+ebNQfynLFe51f5nPDAAscLL7Tqt+Y8bu+qv8OWQx0iOF5AA9xqG7uWsIaYAUJZK7Du
	W0N7W1TANkywbpi922bYKxF/YcLTvjFuC9WdssBkYwrOfBbEhKvzn8Iow4aRN2ETFiy78XC/TD9
	A5vOWQvhXbqn0mSzcb7pXnLjmQ+TrU/5IvSg/ZIE=
X-Google-Smtp-Source: AGHT+IHGXFFKwi9KhnB1akNKraPfzeJ2zmSUqQqb7SzFIxYzfjGRA13Y+veDJQIEsP0m/DU4C4O2oA==
X-Received: by 2002:a17:902:c94a:b0:232:1daf:6f06 with SMTP id d9443c01a7336-23c6e5d3a53mr39666775ad.47.1751467903710;
        Wed, 02 Jul 2025 07:51:43 -0700 (PDT)
Received: from ?IPV6:240e:305:798e:6800:81a5:8e22:d9f1:ac68? ([240e:305:798e:6800:81a5:8e22:d9f1:ac68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3afc94sm138573955ad.155.2025.07.02.07.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:51:43 -0700 (PDT)
Message-ID: <34b3f8f1-5adf-4f82-8d06-b906cdf0552d@gmail.com>
Date: Wed, 2 Jul 2025 22:51:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] fs: change write_begin/write_end interface to take
 struct kiocb *
To: Matthew Wilcox <willy@infradead.org>
Cc: "tytso@mit.edu" <tytso@mit.edu>, "hch@infradead.org" <hch@infradead.org>,
 "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "chentao325@qq.com" <chentao325@qq.com>,
 "frank.li@vivo.com" <frank.li@vivo.com>
References: <20250627110257.1870826-1-chentaotao@didiglobal.com>
 <20250627110257.1870826-4-chentaotao@didiglobal.com>
 <aF6-L5Eu7XieS8aM@casper.infradead.org>
From: Taotao Chen <chentt325@gmail.com>
In-Reply-To: <aF6-L5Eu7XieS8aM@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/27 23:52, Matthew Wilcox 写道:
> On Fri, Jun 27, 2025 at 11:03:11AM +0000, 陈涛涛 Taotao Chen wrote:
>> @@ -1399,13 +1400,10 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
>>   }
>>   
>>   /*
>> - * We need to pick up the new inode size which generic_commit_write gave us
>> - * `file' can be NULL - eg, when called from page_symlink().
>> - *
> Why delete this?  It seems still true to me, other than s/file/iocb/
Sorry, that was my mistake...

