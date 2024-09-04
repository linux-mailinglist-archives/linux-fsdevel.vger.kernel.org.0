Return-Path: <linux-fsdevel+bounces-28561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC096C08A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D282896D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D1A1DB93C;
	Wed,  4 Sep 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EK6m47HZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C941DA609
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460255; cv=none; b=r6cyEd747ap5JmZB7n3i9spgCcwzEthTuIXay3kN4TRdKzBphHaLBr87Wa4PQ7KYhMVmFYbRtJEjrV5KO4L77rfFJSWH1agriZRL1NSm+5fYdIfClQ/QllVtu8r6//HR52tc8rzWdm7b+dq1mikb6iK/h8Tj4CxnL6tq2zt9xO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460255; c=relaxed/simple;
	bh=+ZXu6meYUp2emnk1pUEFpHVRsMcDsWR9d9edP3JL+tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlF7Ubf2qetELejTPJUx5vmCETLXBTrXXs5Y/MOUC97tIimmO5bJbl7j2bV5vam1geeHJRQ2InPp5+lvnOS6G4o0bJHz8h+qrXRBA3ZVNbEvuqa5irUt44kClAqbUnrhpoMEAETOGRp14xX1IVIT9iKGFao72KDe0DTF7bzx78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EK6m47HZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a866cea40c4so776297766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725460252; x=1726065052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mj+3ddf2T3OL11MVG0wgLWW55Rk8MJvA3KeiKNlFbs=;
        b=EK6m47HZAyHgIrhryObg0UtFiQrm6tdnwPgHZ5pMSgAmtRt3Pt7IBgyJ5zD31UMF6T
         7qLWVlQ1PUobHBeqlhByfSoZ1ps4Zzhve0rsDaOTcJKq8wuodsLqUUfb9jDJwbO7KxDO
         MkiV78wAQHf5p0+oqa00nbHa1N+zmmXBBRdCjTQ34f7J+2TAeiHi36RnJ82VbhOKBXLa
         8kNJC5wssnJFt+ZgRIbyAX0GFyRlmimAMnuKjGeOeMGzmua+cm5VlSt8NmDkWXu7oCeY
         gleAH4VphEPkctfggHZVn3FRuxK4yHtOiUMcJw/2cBZG41sfK2TVUAYuo/5Z1z1Ii1Bb
         kc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460252; x=1726065052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mj+3ddf2T3OL11MVG0wgLWW55Rk8MJvA3KeiKNlFbs=;
        b=ilpcJlQANwynSPeODhOo9CO1LVf0KfBMCooZvWJ78BOpgZ2kMWsVme+VnR1OEeF0FM
         7ozOjdR3gYMBvDc89TcfBH+Aet5v62KmShytxD6H/ZVvDjH5AeO9JUUxcqXeHsiPYN6y
         m/7E/YCsfQh4ratGohR3M9wjh2Z4h5BEj/XgW3AubCQEwNWIOfjr+daPP+1m3gy3LCyp
         OGLChSETbou8lw7OVB2FtGUgoru9G97/3rZnmVBcwxwxHSY5cKKSjvsu20hD8EP6CpDT
         NCVYHQrUcKXLZH9r7xnDh1ekFOSl0tN37yiSx0vi6MktYwDTtGck+A+SW903Gf3pykMW
         hH8A==
X-Forwarded-Encrypted: i=1; AJvYcCXYqLwnmqk7ktWb16ynliMH7pssnNvXs8PmF1kRbVXt7e6wxDejyazgienjer+oC1TEwtgL8lZP8LH2sUwG@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQ4Weq7ThasyfDNiChIEPB6Hv48ZUFk8uh9hyJALUd4jplKyo
	q9hfr/3xb5ndZlnfyP4qxzIFNZB3rVm1lcpU0sOxYfGoXrQ0Ge++NcfVrYuZ8dE=
X-Google-Smtp-Source: AGHT+IFMOIxyP6G+sV9SFwQbLa7RzZxnlSRsBYqqYkhtUdWNAPfVNmkYr+B0Ioi6gh+avo5V5Q6aYQ==
X-Received: by 2002:a17:907:7206:b0:a89:9a9d:4e13 with SMTP id a640c23a62f3a-a8a1d56efbdmr693848266b.56.1725460251935;
        Wed, 04 Sep 2024 07:30:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3ceasm810608566b.115.2024.09.04.07.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:30:51 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:30:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v6 00/17] add threaded printing + the rest
Message-ID: <ZthvGoJE26dOtsLm@pathway.suse.cz>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>

On Wed 2024-09-04 14:11:19, John Ogness wrote:
> Hi,
> 
> This is v6 of a series to implement threaded console printing
> as well as some other minor pieces (such as proc and sysfs
> recognition of nbcon consoles). v5 is here [0].
> 
> For information about the motivation of the nbcon consoles,
> please read the cover letter of the original v1 [1].
> 
> This series provides the remaining pieces of the printk
> rework. All other components are either already mainline or are
> currently in linux-next. In particular this series does:
> 
> - Implement dedicated printing threads per nbcon console.
> 
> - Implement forced threading of legacy consoles for PREEMPT_RT.
> 
> - Implement nbcon support for proc and sysfs console-related
>   files.
> 
> - Provide a new helper function nbcon_reacquire_nobuf() to
>   allow nbcon console drivers to reacquire ownership.
> 
> Note that this series does *not* provide an nbcon console
> driver. That will come in a follow-up series.

JFYI, the patchset has been committed into printk/linux.git,
branch rework/threaded-printk.

I am not completely sure if we add this early enough for 6.12.
On one hand, the patchset should not change the handling of legacy
consoles and it does not add any nbcon console. But it touches
many code paths where we decide how to flush the consoles
and could imagine doing "ugly" mistakes there.

OK, let's see how it works in linux-next in the following days.
There is still time to catch problems and make the decision.

Best Regards,
Petr

