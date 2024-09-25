Return-Path: <linux-fsdevel+bounces-30106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A298641B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2911C26866
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F851BC58;
	Wed, 25 Sep 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="TmW9vfQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3331A29A;
	Wed, 25 Sep 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279392; cv=none; b=tfcR9vtHfQSKaygS68IOYX1qH/YtR3wYb25nVgj/oPOruMKXzKUbL408yhx6VFnFE69MxZ7ynftFhMQVh/V8d7W6gn5o8Y28601jS6t8fdxKmuM7Y2wZGUOiiDLsB4l+MRYSvZ7erLLNIlTdnPT62LM5ts4F0DClsP9uaY8d/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279392; c=relaxed/simple;
	bh=danQdMcwzKfF3crSfdrq3/vNVhfp5ODpJa2SM9OmHR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmCinSoL1sg3w6Y1yQvI6Tfcmuyt7BRLN1TxLLRT9ezZQN8OuCMlXnRIM3SWP/vVt7vEg4HsWhRAcpegtghuSIloyLj8v8V/bs5EHJ+1xF9w2cIelc9Tl56Y9hWr62tw3SdR9Uxx1Pt7SrEf3ux9gq1EMLCEfIKBBBb1SclxM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=TmW9vfQ9; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4990; q=dns/txt; s=iport;
  t=1727279390; x=1728488990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=84x+b1yJmo5yjAGxNW6xYtoM6UF1YBrDV7rxlGckoBg=;
  b=TmW9vfQ9BBxIF7DAKFBt0MiUx4TPpxAnnPAWcWCcyXKa3wN4wYqkZvcG
   L0EIqvsH84Hk0+oAxuNAmb4+3uaVfX8j/KBJZ/EkCyPvclvdzn0N396eE
   1Ghyjo/ycD8ke2yxoMj7mxoQuvJuCEoZ2syOFX0AjTsEznaEEOLpq5FWu
   k=;
X-CSE-ConnectionGUID: YATZGHMxRxSMaM7FgO50rg==
X-CSE-MsgGUID: s3VwVFXbRFe+N0aYayv+bA==
X-IPAS-Result: =?us-ascii?q?A0DEAAAvMPRmmI9dJa1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+EFgRDlGqCIgOgEw8BAQENAQFEBAEBhQcCigMCJjgTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQUBAQUBAQECAQcFFAEBAQEBAQEBNwVJhTsBBUGGXAEBAQM6PxALG?=
 =?us-ascii?q?C5WBoMUgmUDr0F4gTSBAd4ygWyBSIhLAYVmhHcnG4FJRIM9gQI+hBqGbQSSC?=
 =?us-ascii?q?YEnhDpvUIIVgT18JU2JA5BnUnt4IQIRAVUTFwsJBYk4CoMcKYFFJoEKgwuBM?=
 =?us-ascii?q?4NygWcJYYhJgQ2BPoFZAYM3SoNPgXkFOAo/glFrTjkCDQI3giiBDoJahQAlH?=
 =?us-ascii?q?UADC209NRQbsGsbG4EUGUZhFUEaDEsDlgOOYp9FgT6EIaE8TRMDg2+NAQOGQ?=
 =?us-ascii?q?TqSQZh2o1yFFwIEBgUCF4F+I4FbMxoIGxWDI1EZD4hKgyqCOQ0JxAJDbQIHC?=
 =?us-ascii?q?wEBAwmLVYF9AQE?=
IronPort-Data: A9a23:J6gqHKyvgdNZlPRo0VJ6t+dMwSrEfRIJ4+MujC+fZmUNrF6WrkUOy
 jQcUGyBPviJYmqne9gnOo20pk4GsMLQy4NlGVRp+1hgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCKa/FH1a+iJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 IuaT/H3Ygf/h2YlaD9MsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJHAfAb832sNnO3F10
 PU9dx4CSU3bne3jldpXSsE07igiBNPgMIVasXZ6wHSGS/0nWpvEBa7N4Le03h9p2ZsIRqmYN
 pFfMGY0BPjDS0Un1lM/AZc/l/qsj2LXeDxDo1XTrq0yi4TW5FYvjei1bIuIJbRmQ+1OxXiHm
 Ez29V7XD1I8bNWuwCubsXiF07qncSTTA99KS+biqZaGmma7wm0VFQ1TWEG8r+KRjk+lR8kZL
 F4Q8yA1668o+ySDStj7Qg39rmWIswARX/JOHOAgrgKA0KzZ50CeHGdsZiBActsOpsIwRCJs0
 l6PgsOvAiZg9qCWIVqZ97GJvXaxNDITIGsqeyAJV00G7sPlrYV1iQjAJv5sCqO6jd3dHTD23
 iCEqzU4i7wPjMkNkaKh8jjvmS+3ut3HSRRw4gTRQ3KN8Ax0fsimapau5Fyd6uxPRK6FSV6Fu
 XECg+CC6OUWS5qG/ASCSf8cNL6g/eeKLTqah1Nzd7Eh7DWk/XGgdId45DB4OVcvO8IFczbja
 QnYvgY5zJVeOn2tK6tweJmwDewy16/8EtKjU/28UzZVSoJ6eAnC9yZ0aAvPmWvsi0Mr16o4P
 P93bPpAE14rIJhV4xqTV90N6poi438QykSOHYr0mkHPPaWlWFaZTrIMMV2rZ+8/7b+ZrAi9z
 zq5H5XWo/m4eLOiChQ74bIuwUY2wW/X7K0aRuRNfeKFZwFhAmxkVLnawKgqfMpumKE9egb0E
 pOVBBEwJLnX3CGvxeC2hpZLM++HsXFX9i5TAMDUFQz0s0XPmK72hEvlS7M5fKM86MtoxuNuQ
 v8Odq2oW6sVFW6foWpMNsCn/eSOkShHYyrQZ0JJhxBiL/Zdq/DhoIOMkvbHrXNXV3Hm76PSX
 ZX7jlqCHPLvuDiO/O6NNarwlAnu1ZTssOlzREDPasJCY1nh9ZMiKir6yJcKzzIkd33+Ks+h/
 1/OW38w/LCVy6dsqYmhrf7f9e+BTbAhdne26kGGt95awwGAoDr6qWKBOc7VFQ3guJTcof/yO
 LUFlqqgb5XqXj9i6uJBLlqi9opmj/OHmlOQ5l0M8KnjB7hzNo5dHw==
IronPort-HdrOrdr: A9a23:8f0Yp6gBTjOILD/Aen29Li1ZjHBQXvUji2hC6mlwRA09TyVXra
 +TddAgpHrJYVcqKRMdcL+7UpVoLUmwyXcx2/h0AV7AZniEhILLFuBfBOLZqlWKJ8S9zI5gPM
 xbHZSWZuedMXFKye7n/Qi1FMshytGb/K3tuf3T1B5WPGZXg2UK1XYBNu5deXcGIjV7OQ==
X-Talos-CUID: =?us-ascii?q?9a23=3ACqO9AmiWcQQI1c16sELUCkzXuTJuQ1Th/ljwBl+?=
 =?us-ascii?q?CGV1MQZjKZ1C3pft+nJ87?=
X-Talos-MUID: 9a23:mpIE4QoO4b9yPD/lwb0ezyo5CthWzZSkMm4A0rNesviNJDIzMR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,257,1719878400"; 
   d="scan'208";a="265804957"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 15:48:40 +0000
Received: from localhost ([10.239.198.28])
	(authenticated bits=0)
	by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 48PFmbaC008220
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Sep 2024 15:48:40 GMT
Date: Wed, 25 Sep 2024 18:48:31 +0300
From: Ariel Miculas <amiculas@cisco.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Gary Guo <gary@garyguo.net>,
        Yiyang Wu <toolmanp@tlmp.cc>, rust-for-linux@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.239.198.28, [10.239.198.28]
X-Outbound-Node: rcdn-core-7.cisco.com

On 24/09/19 07:36, Benno Lossin via Linux-erofs wrote:
> On 19.09.24 17:13, Gao Xiang wrote:
> > Hi Benno,
> > 
> > On 2024/9/19 21:45, Benno Lossin wrote:
> >> Hi,
> >>
> >> Thanks for the patch series. I think it's great that you want to use
> >> Rust for this filesystem.
> >>
> >> On 17.09.24 01:58, Gao Xiang wrote:
> >>> On 2024/9/17 04:01, Gary Guo wrote:
> >>>> Also, it seems that you're building abstractions into EROFS directly
> >>>> without building a generic abstraction. We have been avoiding that. If
> >>>> there's an abstraction that you need and missing, please add that
> >>>> abstraction. In fact, there're a bunch of people trying to add FS
> >>>
> >>> No, I'd like to try to replace some EROFS C logic first to Rust (by
> >>> using EROFS C API interfaces) and try if Rust is really useful for
> >>> a real in-tree filesystem.  If Rust can improve EROFS security or
> >>> performance (although I'm sceptical on performance), As an EROFS
> >>> maintainer, I'm totally fine to accept EROFS Rust logic landed to
> >>> help the whole filesystem better.
> >>
> >> As Gary already said, we have been using a different approach and it has
> >> served us well. Your approach of calling directly into C from the driver
> >> can be used to create a proof of concept, but in our opinion it is not
> >> something that should be put into mainline. That is because calling C
> >> from Rust is rather complicated due to the many nuanced features that
> >> Rust provides (for example the safety requirements of references).
> >> Therefore moving the dangerous parts into a central location is crucial
> >> for making use of all of Rust's advantages inside of your code.
> > 
> > I'm not quite sure about your point honestly.  In my opinion, there
> > is nothing different to use Rust _within a filesystem_ or _within a
> > driver_ or _within a Linux subsystem_ as long as all negotiated APIs
> > are audited.
> 
> To us there is a big difference: If a lot of functions in an API are
> `unsafe` without being inherent from the problem that it solves, then
> it's a bad API.
> 
> > Otherwise, it means Rust will never be used to write Linux core parts
> > such as MM, VFS or block layer. Does this point make sense? At least,
> > Rust needs to get along with the existing C code (in an audited way)
> > rather than refuse C code.
> 
> I am neither requiring you to write solely safe code, nor am I banning
> interacting with the C side. What we mean when we talk about
> abstractions is that we want to minimize the Rust code that directly
> interfaces with C. Rust-to-Rust interfaces can be a lot safer and are
> easier to implement correctly.
> 
> > My personal idea about Rust: I think Rust is just another _language
> > tool_ for the Linux kernel which could save us time and make the
> > kernel development better.
> 
> Yes, but we do have conventions, rules and guidelines for writing such
> code. C code also has them. If you want/need to break them, there should
> be a good reason to do so. I don't see one in this instance.
> 
> > Or I wonder why not writing a complete new Rust stuff instead rather
> > than living in the C world?
> 
> There are projects that do that yes. But Rust-for-Linux is about
> bringing Rust to the kernel and part of that is coming up with good
> conventions and rules.
> 
> >>> For Rust VFS abstraction, that is a different and indepenent story,
> >>> Yiyang don't have any bandwidth on this due to his limited time.
> >>
> >> This seems a bit weird, you have the bandwidth to write your own
> >> abstractions, but not use the stuff that has already been developed?
> > 
> > It's not written by me, Yiyang is still an undergraduate tudent.
> > It's his research project and I don't think it's his responsibility
> > to make an upstreamable VFS abstraction.
> 
> That is fair, but he wouldn't have to start from scratch, Wedsons
> abstractions were good enough for him to write a Rust version of ext2.
> In addition, tarfs and puzzlefs also use those bindings.
> To me it sounds as if you have not taken the time to try to make it work
> with the existing abstractions. Have you tried reaching out to Ariel? He
> is working on puzzlefs and might have some insight to give you. Sadly
> Wedson has left the project, so someone will have to pick up his work.

I share the same opinions as Benno that we should try to use the
existing filesystem abstractions, even if they are not yet upstream.
Since erofs is a read-only filesystem and the Rust filesystem
abstractions are also used by other two read-only filesystems (TarFS and
PuzzleFS), it shouldn't be too difficult to adapt the erofs Rust code so
that it also uses the existing filesystem abstractions. And if there is
anything lacking, we can improve the existing generic APIs. This would
also increase the chances of upstreaming them.

I'm happy to help you if you decide to go down this route.

Cheers,
Ariel

