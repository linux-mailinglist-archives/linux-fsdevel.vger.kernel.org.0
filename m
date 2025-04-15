Return-Path: <linux-fsdevel+bounces-46449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E9DA89842
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8DF1896E6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05828DEF0;
	Tue, 15 Apr 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="q+RQZ2aP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C928A1E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709986; cv=none; b=YxvuAexh5JNBtBsUBznGNB7I/xKz+eo14lLFg7+Z+LMoV6DqsszvEAhUdf1zkCVnNlh40k7M9+5akvoRnFeKfygvxY1Kzseo2wewMPAjoJfBxK5H0gS9W89/0UWLUa7t6IPHcMUm7oKHXbJt/qzJGI1SNu5JVAyCChgclj6IZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709986; c=relaxed/simple;
	bh=+eLU52m0ORdIdJCapPT1WBaFvqjvCeD37wwm9qhfv7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLTw3LqtHMIY9SEQc7BUwNK6enrMF3HJWj9WOe4ROtO+yOhq5NZ70wrOD5VQ+WC5N7Yw11O5Xu7Chi8PS4LH+Iq+JxUxBhIDX7raFhqC8bhoylL8g9QKgEWV5nZe1bX7IRIIUK86BXA0MY581V7QV8qXpAEhIeIJBnrBQPu7yYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=q+RQZ2aP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-477296dce76so45426001cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744709983; x=1745314783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp5QhzXK0d3ipbL7De1Z7Dt2PtgQVBDiovxjTMuv9UE=;
        b=q+RQZ2aP6N7OS7xlRi3J4F+VzBhsXV1hxTB2Lt0jwKXqahoAg5W64SgCncWenV+sB0
         CjwTXNgC1EV4On/xfAdMdzxEMG5V1g0lzEuvZsGNpf1EKHT7KcUXUdsuhfJa0wnwglgq
         yq6U5qftICTN+V0xK1cRhgv2yxrmGUZtw7dW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744709983; x=1745314783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp5QhzXK0d3ipbL7De1Z7Dt2PtgQVBDiovxjTMuv9UE=;
        b=WFSLUSwnMW+KewgM3DwW2wvu3FjX9NlXoSqY8xTLuZ5QRL3Nw4vyNt31C+hHNDWpUq
         9M2JSTmbTapKN8Oy/c+0F/F0PgTSxiZUShKNvw5V0rmiteJysJmqU7+Tayc2xj9VsnuT
         fKSuPpi4V8DXLen8KS7FkGvFYNBHvNyP3CzXy/N/8D2Za0UZXzOXB4ALnXbRVg761E4N
         KrFVZmfPBUZQOdbGUNKexn6+yWQENGGMNoFm4a0duCxcegzQkAKtnUpd6AkesWWEKH4R
         FgFze3GiMI3+PcohXdAzkBucxxhQcwwGZdg0AdLUdrWJyXZft3r2/Yd2CwLaERfI+spv
         fczw==
X-Forwarded-Encrypted: i=1; AJvYcCX8laAYi+maKMtvs7AbPvFyvruRuJLTdXs0jVDbAmjwV1Ggmoq8RlWYq5fU0WOGijErtgpqYL83xBOvZ4NR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj/Xrt6ii0mA8BD34MRSTWQjyeflblZ9w26vyDQtShgjhGIVIH
	kHT4u2xLhR3AJKZh0nUKuaC1wIpmoybAPIvmQTZrbZ9orIyA7nlSnbcsbY/SEdE3qLiNMkCxPK2
	6XgVJnNg5jJQVSl8VrSg/kazcvajjGbhAmLrkVw==
X-Gm-Gg: ASbGncu62XiFxu65QBVDKH2BqXCQ3aYiDdlc9/L6FZh/LOD7OJRLZ6af3VAZeZlmOah
	R68qcHN+iMq2byYZJlgS/2PuYjf14DDBahewk2UWROF0NsnsvCYzQglONLh3bHIyDFvBVfhk4/k
	M3mbpszGgQCNXluncSIkc+
X-Google-Smtp-Source: AGHT+IHAloQRbW9NojhcvEEtRbgJNH88Mbd8WiXMbNgiI5cPN7g+71vwOchhjGPft+4cYmSg7Sbt+jh1WcjqLl8RB54=
X-Received: by 2002:a05:622a:28d:b0:476:ac03:3c2a with SMTP id
 d75a77b69052e-479775e9723mr251931571cf.43.1744709982849; Tue, 15 Apr 2025
 02:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-fuse-sysfs-v2-1-b94d199435a7@kernel.org>
In-Reply-To: <20250203-fuse-sysfs-v2-1-b94d199435a7@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Apr 2025 11:39:31 +0200
X-Gm-Features: ATxdqUFhPFymDj11-t61NAng2LH1InHt-a0YDOQdAb8tGbHo3D0mz7v0DZE-BT0
Message-ID: <CAJfpegtLjFVRLxeUUGjT1V0iQ8+pwsFn0t2n2yOVfqSjn_7bPg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: add a new "connections" file to show longest
 waiting reqeust
To: Jeff Layton <jlayton@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Feb 2025 at 20:57, Jeff Layton <jlayton@kernel.org> wrote:
>
> Add a new file to the "connections" directory that shows how long (in
> seconds) the oldest fuse_req in the processing hash or pending queue has
> been waiting.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This is based on top of Joanne's timeout patches, as it requires the
> "create_time" field in fuse_req.  We have some internal detection of
> hung fuse server processes that relies on seeing elevated values in the
> "waiting" sysfs file. The problem with that method is that it can't
> detect when highly serialized workloads on a FUSE mount are hung. This
> adds another metric that we can use to detect this situation.
> ---
> Changes in v2:
> - use list_first_entry_or_null() when checking hash lists
> - take fiq->lock when checking pending list
> - ensure that if there are no waiting reqs, that the output will be 0
> - use time_before() to compare jiffies values
> - no need to hold fc->lock when walking pending queue
> - Link to v1: https://lore.kernel.org/r/20250203-fuse-sysfs-v1-1-36faa01f2338@kernel.org
> ---
>  fs/fuse/control.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h  |  2 +-
>  2 files changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..b27f2120499826040af77d7662d2dad0e9f37ee6 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -180,6 +180,57 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
>         return ret;
>  }
>
> +/* Show how long (in s) the oldest request has been waiting */
> +static ssize_t fuse_conn_oldest_read(struct file *file, char __user *buf,
> +                                     size_t len, loff_t *ppos)
> +{
> +       char tmp[32];
> +       size_t size;
> +       unsigned long now = jiffies;
> +       unsigned long oldest = now;
> +
> +       if (!*ppos) {
> +               struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
> +               struct fuse_iqueue *fiq = &fc->iq;
> +               struct fuse_dev *fud;
> +               struct fuse_req *req;
> +
> +               if (!fc)
> +                       return 0;
> +
> +               spin_lock(&fc->lock);
> +               list_for_each_entry(fud, &fc->devices, entry) {
> +                       struct fuse_pqueue *fpq = &fud->pq;
> +                       int i;
> +
> +                       spin_lock(&fpq->lock);
> +                       for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
> +                               /*
> +                                * Only check the first request in the queue. The
> +                                * assumption is that the one at the head of the list
> +                                * will always be the oldest.
> +                                */
> +                               req = list_first_entry_or_null(&fpq->processing[i],
> +                                                              struct fuse_req, list);
> +                               if (req && time_before(req->create_time, oldest))
> +                                       oldest = req->create_time;

Couldn't this be merged with the timeout expiry code?  I.e. implement
get_oldest_req_time() helper, the result of which could be compared
against req_timeout.


> +                       }
> +                       spin_unlock(&fpq->lock);
> +               }
> +               spin_unlock(&fc->lock);
> +
> +               spin_lock(&fiq->lock);
> +               req = list_first_entry_or_null(&fiq->pending, struct fuse_req, list);
> +               if (req && time_before(req->create_time, oldest))
> +                       oldest = req->create_time;
> +               spin_unlock(&fiq->lock);
> +
> +               fuse_conn_put(fc);
> +       }
> +       size = sprintf(tmp, "%ld\n", (now - oldest)/HZ);

now - oldest will always be zero if *ppos != 0.  It would be much more
logical to return an error for *ppos != 0, then to return success with
a nonsense value.

use_conn_limit_write() already does so, and existing read callbacks
could be changed to do the same with a very slight risk of a
regression.  But for a new one, I don't think there's any worries.

Thanks,
Miklos


Thanks,
Miklos

