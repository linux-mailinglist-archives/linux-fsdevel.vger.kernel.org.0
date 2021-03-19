Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56CE342328
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 18:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCSRYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 13:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCSRYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:24:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCFAC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 10:24:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l3so6374542pfc.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y3HPFVQQ8OcLuuAynRQtdLIpt1ZlQVl3Ddi5JOdBy0s=;
        b=ijJD/g9ZP1Yyl5fSfAFOPGlYJua+C5SS43o3CNhGgSeVXgnDiCqKQcxgzUtQ61O1a6
         H1DD1WppKq7fzQ315rtxWK9GISWoLs2ph+RpDHyd71ihbwa/fgRSHBtsctslONiHt+uZ
         IeDn5qP5KUNNOs2PjSdqbqFrlcXgz6WS/Gnp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y3HPFVQQ8OcLuuAynRQtdLIpt1ZlQVl3Ddi5JOdBy0s=;
        b=TSN/6nDhI5/bhNsQfmBSp5DSZmtEF1gj0LWkqWdRkGjKKmj+6pfpBdWnVx1dMCuQR4
         iPDstipw+2kx0Wk0k8PPgZAjePVbrxUBpLSc0GxREA22YK3X461L8iIiYDq3q6dTFqGj
         tYW7IGZzoYNDZy0hSi5kT0BgaklqBSEwI8UwBzbydpI3BC+1DCSObMXes7ybofhv9I0m
         4FMK2FojNVpoZY1JivaBam8tFCzDL3BZhq0+S6A74ziMHMWlJ7mh/Y3Hhnx6mROPOZj1
         T89ytYCSHKivoKYURDa4/7Glz9EdpAE8CnY93GRbpv0iDzCQVyj/gMpMeL9WvFOxnhMf
         kVjg==
X-Gm-Message-State: AOAM53130L7gvKACwTbfEih6+jH/thWxAzpHlosHzX8aYwIRiw1ScrzF
        mqskQKuSzdXMZNsgnpnabWWf9g==
X-Google-Smtp-Source: ABdhPJxof2S7NAyn0wwLIRht63qQ8yxLGkdNHCaohi74HUCi/0cELJkStbwnSdwtemmhQBNrzgFv4w==
X-Received: by 2002:a65:4887:: with SMTP id n7mr12266351pgs.14.1616174671959;
        Fri, 19 Mar 2021 10:24:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2sm5994795pfi.116.2021.03.19.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:24:31 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:24:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v30 05/12] LSM: Infrastructure management of the
 superblock
Message-ID: <202103191024.40EBCA2C@keescook>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-6-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316204252.427806-6-mic@digikod.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:42:45PM +0100, Mickaël Salaün wrote:
> From: Casey Schaufler <casey@schaufler-ca.com>
> 
> Move management of the superblock->sb_security blob out of the
> individual security modules and into the security infrastructure.
> Instead of allocating the blobs from within the modules, the modules
> tell the infrastructure how much space is required, and the space is
> allocated there.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
