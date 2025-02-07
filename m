Return-Path: <linux-fsdevel+bounces-41169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E32A2BEAA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6857A7A4F2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF11D5AB7;
	Fri,  7 Feb 2025 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1O4WuC3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB81CDA2D
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919010; cv=none; b=YTtu7XGQAbzMrB+vszBLO/nCbzJtJf9xNDK4LR7dn7TX/C1FLTdcuMt36TG2LQlu8Wvzkxoj34VYwFWsSIg4xvNGN7DkHDv6EPJxDsar5oecdun8uw3RfdYHI3abFjbhJUI8MgsJyZnRVD+ef9LQyrWYv+W6gMhYI0HhiFrV0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919010; c=relaxed/simple;
	bh=MEVroBLkSTdE1yIMJco/ozmWYaB5sSU4ztneSdlIaIM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r8sULOHp6/d2ZYVIWFjhkz2bdt4Oh03SvQJy/fVhzVZwNiRfP+Irc/FdvIgd83v83xneMOzWodiynxMmLsfWhLCPlM2/TyelzM7FW9nXT9BqroEN698J5iMIM95fR6Ulrjkpct6tuqUFsMBeonRJ9mtG44HXysFNUhAJ8YDZ4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w1O4WuC3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dc33931d3so643761f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 01:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738919007; x=1739523807; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dU/wMxzTDYOcfJApwwB0NhGqU/FaaA8rHV0WmWnGAEY=;
        b=w1O4WuC369NErK6w7QslKF6+AKyf3iIoZjf2yRQXImGejst9e+nULULleZLZKbug/a
         jEOkbg++6hXXTrhO774HU6H40owOQduU8LrBnnYd86PsgQq2Fm4Uhb3j4IrNvu1eOgw2
         Jd0UTQ/e/KXjty79MD4v2DF0vgxGWPdJzjH/ABDPACHQUuSVloSRBNiO2jvrlywqN81X
         djuUZLD4bILqiA/5XLrh/a5wxiSYuo0bLFEWzW+olLceEGrhq69YKhxpgqcuihja0N06
         lwA3dcTZ2yGS7BYIeZhLX0x7RErVlO5wyiMPHOEqwtJeaSYJrGXqDjQCad50OB/z5SEs
         /JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738919007; x=1739523807;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dU/wMxzTDYOcfJApwwB0NhGqU/FaaA8rHV0WmWnGAEY=;
        b=R05DNlOMl6Jr3fmTGoNaZRji3jciurSV0npZYkSyi/N08O+UZLXFrUfoncp1mFPXWi
         Ex+Cn028vwtEaq5lSBvneu/ep9oHggjrG6hQjKM9EYUGGnmEITQPJp+nK34bbOMlT0tt
         LgTZOX8SIVaizN+eqIY0jJO/bNa4wjxW1XABZk2bSC8RxQprgmf1TSZ2qCSaEzrYB9cZ
         aRRdH+RkpwmzKywnB87UpMkeDZmwDtr6CmVeWmr9ZvrK9VpRFC/YJ7gXGPucuTpZzdrJ
         HeVNllqluKcYPhL0SIPx+3A0Tr93sTXVORsiOyioKs/pCwFIE/ygBaSKu2ZfT8EI2YbQ
         32bg==
X-Gm-Message-State: AOJu0YxN52nLU0lER9VhIL/zBMHClvtJGswoJ0MyOdp57Yyj3ln6JSej
	avQx6xzUq3M+t4L6oxmgPiU92kZ306Rbhgkxy6sF99cFTn/LwVA9A5xMhhRMGdo=
X-Gm-Gg: ASbGncs9yAKkA16hIA2jEhngon0WZn3qdn7xLrqYL4dseCWEJ0YMKV63cqNkv89YWwG
	r2Y872hjL7wDkOajQGEof/cuGLrjpokwiUbbsk7zk8tSoqu8bwC+Po4PulqnFJHJM71bdZxoTfi
	Q0mbXAZK+F/b5e839uarMZHAJgeYC5IWHf6UNNFa8nuyirJulLupv93KSPjJC9m9ZGdPamFwJ7G
	PvV0JN9rDh+Xcs8n5oTxTfnNXSwuHbhO+sPMCU6KcO2RQHDx4b1aE8K1zwBk+WJUMDtqNHYzbrp
	QJOqr93vf08SVcaL11x2
X-Google-Smtp-Source: AGHT+IFoPCxu0mJpM/NbJTxaS4i1Ylfijb4tNGaKbnXjRhKB3zuKQFYWsXZ/A0BAywEm/LakH3OKLg==
X-Received: by 2002:a5d:47ca:0:b0:385:e8b0:df13 with SMTP id ffacd0b85a97d-38dc93338dfmr1654929f8f.40.1738919006989;
        Fri, 07 Feb 2025 01:03:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dce8e34f5sm297111f8f.58.2025.02.07.01.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 01:03:26 -0800 (PST)
Date: Fri, 7 Feb 2025 12:03:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] statmount: allow to retrieve idmappings
Message-ID: <a4ef5f7d-9a6c-4f24-b377-557c3af0182f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Christian Brauner,

Commit f8c6e8bd9ad5 ("statmount: allow to retrieve idmappings") from
Feb 4, 2025 (linux-next), leads to the following Smatch static
checker warning:

	fs/namespace.c:5468 statmount_string()
	error: uninitialized symbol 'offp'.

fs/namespace.c
    5388 static int statmount_string(struct kstatmount *s, u64 flag)
    5389 {
    5390         int ret = 0;
    5391         size_t kbufsize;
    5392         struct seq_file *seq = &s->seq;
    5393         struct statmount *sm = &s->sm;
    5394         u32 start, *offp;
    5395 
    5396         /* Reserve an empty string at the beginning for any unset offsets */
    5397         if (!seq->count)
    5398                 seq_putc(seq, 0);
    5399 
    5400         start = seq->count;
    5401 
    5402         switch (flag) {
    5403         case STATMOUNT_FS_TYPE:
    5404                 offp = &sm->fs_type;
    5405                 ret = statmount_fs_type(s, seq);
    5406                 break;
    5407         case STATMOUNT_MNT_ROOT:
    5408                 offp = &sm->mnt_root;
    5409                 ret = statmount_mnt_root(s, seq);
    5410                 break;
    5411         case STATMOUNT_MNT_POINT:
    5412                 offp = &sm->mnt_point;
    5413                 ret = statmount_mnt_point(s, seq);
    5414                 break;
    5415         case STATMOUNT_MNT_OPTS:
    5416                 offp = &sm->mnt_opts;
    5417                 ret = statmount_mnt_opts(s, seq);
    5418                 break;
    5419         case STATMOUNT_OPT_ARRAY:
    5420                 offp = &sm->opt_array;
    5421                 ret = statmount_opt_array(s, seq);
    5422                 break;
    5423         case STATMOUNT_OPT_SEC_ARRAY:
    5424                 offp = &sm->opt_sec_array;
    5425                 ret = statmount_opt_sec_array(s, seq);
    5426                 break;
    5427         case STATMOUNT_FS_SUBTYPE:
    5428                 offp = &sm->fs_subtype;
    5429                 statmount_fs_subtype(s, seq);
    5430                 break;
    5431         case STATMOUNT_SB_SOURCE:
    5432                 offp = &sm->sb_source;
    5433                 ret = statmount_sb_source(s, seq);
    5434                 break;
    5435         case STATMOUNT_MNT_UIDMAP:
    5436                 sm->mnt_uidmap = start;
    5437                 ret = statmount_mnt_uidmap(s, seq);

offp not initialized

    5438                 break;
    5439         case STATMOUNT_MNT_GIDMAP:
    5440                 sm->mnt_gidmap = start;
    5441                 ret = statmount_mnt_gidmap(s, seq);

Same here

    5442                 break;
    5443         default:
    5444                 WARN_ON_ONCE(true);
    5445                 return -EINVAL;
    5446         }
    5447 
    5448         /*
    5449          * If nothing was emitted, return to avoid setting the flag
    5450          * and terminating the buffer.
    5451          */
    5452         if (seq->count == start)
    5453                 return ret;
    5454         if (unlikely(check_add_overflow(sizeof(*sm), seq->count, &kbufsize)))
    5455                 return -EOVERFLOW;
    5456         if (kbufsize >= s->bufsize)
    5457                 return -EOVERFLOW;
    5458 
    5459         /* signal a retry */
    5460         if (unlikely(seq_has_overflowed(seq)))
    5461                 return -EAGAIN;
    5462 
    5463         if (ret)
    5464                 return ret;
    5465 
    5466         seq->buf[seq->count++] = '\0';
    5467         sm->mask |= flag;
--> 5468         *offp = start;
                 ^^^^^^^^^^^^^^

    5469         return 0;
    5470 }

regards,
dan carpenter

