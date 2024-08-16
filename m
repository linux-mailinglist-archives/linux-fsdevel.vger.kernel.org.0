Return-Path: <linux-fsdevel+bounces-26139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35323954EBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F228B20A3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE471BE85F;
	Fri, 16 Aug 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rx58vgHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032C817
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825628; cv=none; b=dma6x1UPOeemiK8uuXQ+C4O/TE1Z3TOWDG8GnXhcS6AQ1ynLYOgJcBsSOis45iSbu5TNNwswXO6p+MyKdr3Dg92yvZO+/SL3oobiiDbx6BkUfTXm89vDv1PQzYvJGHMSAPgLFWWvkwi+ICe7Q+O+qHvAmQY58H0D6O7ctD5auz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825628; c=relaxed/simple;
	bh=uaPezdS1GuGJWsTNrTynbO/VRMTqRqVj4m5lO+Ls+2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUI1T5DVRmcL/3D57XPTBOtyOBmgwIUz4klcjksuXS2CRxf7V83q8wJbnoojhQhYWpAqeeUCnghf96lviNznlhFhre8lA1ppFwADz91dYWTn9GfJxoVNPdUy3CcpAY3wRUwd31dO9Apxs7Fzb+atkOdbVtZiev730ciHFoAYXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rx58vgHr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f01b8738dso2069509e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723825624; x=1724430424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=npZH+zS1GM1eQrs/Gjrg3IK26MlACSY7DOUFz+cptRc=;
        b=Rx58vgHrmBOAsPQX6Ib/a0gSGTYv0vr26v1ZhnrcJOXtuFAj7b0xRfTUV9OeLyGQJk
         i256yfrpZpyN5JyB3rKj2C8HXsvltYO06BwytokYGhPIiqPFXYSHTgB2vda65SXvx8SD
         /T7XU5Pq4DCQ+Ezaeqs1Gsb5Q/FF8SsqWG+9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723825624; x=1724430424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npZH+zS1GM1eQrs/Gjrg3IK26MlACSY7DOUFz+cptRc=;
        b=e6MHucLWg5Ii98A2yQCDgW3C5j5XHKABXZEs61vSfC/8hj5B0TXkccXyVmS6TwuaTo
         PwOqalpFz3TY2iuDqfQrppOGRXrBmjM/fIV08kA3PaFhFTARaSbV9Ac+SRglKE/eKdDy
         I+NB3gGyB+21uQj535ZAk7huOcOZ7M5oT4shkvaG5I9PI4coROCrli4co7wlc5Y6tjgS
         k8LYECsitGd2RML4XjzOQEhnTuKhRFgsKYRjmQ6VTUCM5c+lc7QOeIqWYErNEhSEn7a6
         lPf7HIstljg1f2PSqAJjQWCWSRQRlDw8ERYUiGoC7fJOM9G8hZ660BTn17G0cLj5Tid9
         clxA==
X-Gm-Message-State: AOJu0Yx1fASBmx7G0qcq2cq656UL0ZZi/SRG/bSBtA8THHQlSsjn/g0f
	ULVjNbnVEdnQcDXu1AOCf+UEpIN1mcZg40NSgAgUT7qBqZ7XaZA9G3BxHLJrkCcrtSmJyH2SM8E
	tuZASCA==
X-Google-Smtp-Source: AGHT+IHIcSFOslf8ZLrgm4GgXTLPk6g+OtuV+JEBNn+dbRX59i2IdLSHkAMF2mQcSNCaqVaDIgjhqQ==
X-Received: by 2002:a05:6512:ad2:b0:52c:e00c:d3a9 with SMTP id 2adb3069b0e04-5331c692b9cmr2342582e87.1.1723825623635;
        Fri, 16 Aug 2024 09:27:03 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d3b902csm624919e87.108.2024.08.16.09.27.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 09:27:03 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01afa11cso2776722e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 09:27:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3ca6:b0:52e:6d71:e8f1 with SMTP id
 2adb3069b0e04-5331c6e5392mr2028130e87.53.1723825622341; Fri, 16 Aug 2024
 09:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816030341.GW13701@ZenIV>
In-Reply-To: <20240816030341.GW13701@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Aug 2024 09:26:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
Message-ID: <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
Subject: Re: [RFC] more close_range() fun
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 20:03, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> It *can* actually happen - all it takes is close_range(2) decision
> to trim the copied descriptor table made before the first dup2()
> and actual copying done after both dup2() are done.

I think this is fine. It's one of those "if user threads have no
serialization, they get what they get" situations.

IOW, I can't actually imagine that anybody would be affected by this
in any sane real situation. If you unshare your file descriptors while
another thread is modifying it, and you don't have any serialization
in user space, you are doing odd things.

Now, I'm not opposed to improving on this, but I do think this is a
"stupis is as stupid does" kind of thing that we shouldn't care about.

          Linus

