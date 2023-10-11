Return-Path: <linux-fsdevel+bounces-87-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813377C58B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7CF28253D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCC130FA6;
	Wed, 11 Oct 2023 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kOdm9yp7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C583208CF
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 15:59:16 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69475A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 08:59:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9b7c234a7so16449625ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697039955; x=1697644755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EBM6QELn8ef1132SlMYb+b5mnbgclrgGpye79FUDoA=;
        b=kOdm9yp70z5nFVU+0weI+1eg23cIaj25FheAboD6zB4zEnLNzmjeqLn9MjCX/uc7v0
         C4/BKUtrAVht43EvwZkJQlK7bkNv49u2D9En5mm7ez9Bc55zKqCdToKmdE8T3Lw6rRpc
         IHTxWGl5ZiImOeL93KfhJVcgwO8RBsSsUtx1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039955; x=1697644755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EBM6QELn8ef1132SlMYb+b5mnbgclrgGpye79FUDoA=;
        b=HctnjsHO1jMlsLVW+HzaPH+o1E/A+TFNpLxyZgPGc77May5D+XN434y2L/mhh+GaEg
         KdTTj/z4i31Bicr5VQ3ZIwyb2kWnzLyPn9vfiUk0Ipn9tHd69wGOMoVZOtY/Ddm75P7b
         gasMqRy5QgwneZtkVaBjL9Q8EuyES3EDkqqSbmTXHv/+ZThQEsj1/jHFWk9VL2Rlw5it
         n9du1o94OsSOlxmZ/F4pLgofVfmxhwAtwB6tLiYEQ9uO1ZZdiPtICiVBLctv6LKZuNzv
         VuV2hmKWLX+0y4l4biPmpkVWxU5cEgmWU5IQHkYlHMignum27SU+5UE2zUaJPsSnbLlg
         jV9Q==
X-Gm-Message-State: AOJu0YyMmulN7HBhMyKOHgB5uSzIT36YAlKCWmNRh5w0282PIlChmFXi
	yWCNHFMezblTxXsEAlh4b+lPUfSSjZfydyU5A/8=
X-Google-Smtp-Source: AGHT+IFnhzRKmMknQABhdyRSLqQ/OlvokCEslWYllvOvh9DztjV2jkf9w6Z8A6ji3ZgSPg2SoS9dEQ==
X-Received: by 2002:a17:902:d716:b0:1c7:37e2:13e5 with SMTP id w22-20020a170902d71600b001c737e213e5mr18437786ply.21.1697039954910;
        Wed, 11 Oct 2023 08:59:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902b28700b001c46d04d001sm9681plr.87.2023.10.11.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:59:14 -0700 (PDT)
Date: Wed, 11 Oct 2023 08:59:12 -0700
From: Kees Cook <keescook@chromium.org>
To: Alyssa Ross <hi@alyssa.is>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: allow executing block devices
Message-ID: <202310110857.522FAFCA@keescook>
References: <20231010092133.4093612-1-hi@alyssa.is>
 <202310101535.CEDA4DB84@keescook>
 <87o7h5vcao.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7h5vcao.fsf@alyssa.is>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 07:38:39AM +0000, Alyssa Ross wrote:
> Is it possible to have a file-backed memfd?  Strange name if so! 

Not that I'm aware, but a program could just read the ELF from the block
device and stick it in a memfd and execute the result.

-- 
Kees Cook

