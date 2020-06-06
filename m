Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222A51F0435
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 03:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgFFB6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 21:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgFFB6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 21:58:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA49DC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 18:58:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d66so5784435pfd.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 18:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ubiyZ733CfEJjdLHhaoOsVA1qzS8di3dJmbcr/gH2uM=;
        b=cAQW8ecDYpX05sVWOHMBk1sbV5DXDbFHVqcQUUOEWATk8Z077CtX6sGKmDYPmCQo0j
         cWwStNFFXcL5bGQ5XRO2g4V/CRmVQxBRaFMK96+FjTNOA4HtICtpU1S+KzQYWjz+6hS/
         l+X7QQX1smTeSTPqjUrYKWb3GMIRmesyECBZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ubiyZ733CfEJjdLHhaoOsVA1qzS8di3dJmbcr/gH2uM=;
        b=DafpMoWCTPGV3naUwAIAozSzIvrpUfNnJwp1E2sQ+i6skn0WnMjC+wgBzjM57nuxg1
         rHSdMV89WghHadMitcFw9Zg/RWhAJrQ+qd9RF7xvjFOk3B+iVylZckdn3iDmX580OK7z
         j7NfdJdyVg+DJDCnJT2zJu5XeYrRyiCcH9aE+2aJu2PLQvzY3xAhlQWkbD24IJiHeh/o
         WTh7z9KrpR4gyay7uKQ6KZfl/hw5VlXq+p8ml87uqgi2GDexctjJffayvZF7q2ETe/45
         807C1TmzqDRIrT6EKfn07l1Ld1+wetP/C4DxDzPQx44aTIVauQvH4GtaaUlgXYCBV+RL
         bG6w==
X-Gm-Message-State: AOAM5316sE8RhbuwC0peM9z25I4U6ydkZCZ+7GKywr76wCrdeo81Ty5z
        dVVLPvwtMjkWbQWfY3ZcU8KYFg==
X-Google-Smtp-Source: ABdhPJyeGr9iCUKxjFBLcQwcqAStcKGLhCd1nJ9DaQgFhqK2lIGzXeCTkSGZWy0vIFqUT4/Fcwv0Dw==
X-Received: by 2002:aa7:8bd0:: with SMTP id s16mr12878768pfd.80.1591408733436;
        Fri, 05 Jun 2020 18:58:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y136sm787864pfg.55.2020.06.05.18.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 18:58:52 -0700 (PDT)
Date:   Fri, 5 Jun 2020 18:58:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-afs@lists.infradead.org,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/27] afs: Detect cell aliases 1 - Cells with root
 volumes
Message-ID: <202006051849.746915FD@keescook>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
 <159078973503.679399.3701716594246594498.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159078973503.679399.3701716594246594498.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 11:02:15PM +0100, David Howells wrote:
> +static struct afs_volume *afs_sample_volume(struct afs_cell *cell, struct key *key,
> +					    const char *name, unsigned int namelen)
> +{
> +	struct afs_volume *volume;
> +	struct afs_fs_context fc = {
> +		.type		= 0, /* Explicitly leave it to the VLDB */
> +		.volnamesz	= namelen,
> +		.volname	= name,
> +		.net		= cell->net,
> +		.cell		= cell,
> +		.key		= key, /* This might need to be something */
> +	};
> +
> +	volume = afs_create_volume(&fc);
> +	_leave(" = %px", volume);
> +	return volume;
> +}

This really doesn't seem like a justified[1] place for %px. (Even if
_leavel() is debug-only, all the rest of _leave() uses are %p.)

> +	default:
> +		BUG();

And nothing should add BUG() to new code[2].

-Kees

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#p-format-specifier
[2] https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

-- 
Kees Cook
