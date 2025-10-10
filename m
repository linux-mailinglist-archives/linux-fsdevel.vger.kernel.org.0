Return-Path: <linux-fsdevel+bounces-63790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCDFBCDD9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF16A540116
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAB62FBDF0;
	Fri, 10 Oct 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzTrdYeF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54CA2FB99C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111106; cv=none; b=RFsR7B661BO0/AlLDITKlTSPgLUXrdSfkc3BHnB2D4PrmgfvD0arZiUn2PDPanjlQHB49lt8KT/LyN7k1OsL0sFwVOz5xFIqUcjTKeJeZMkDkFE0LXrjhHHzGPJ53XDNWFOTXphmd/UgBlyvVPc3d6aXHAV6jVOBwQyabwGD2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111106; c=relaxed/simple;
	bh=piy9ZqSedxF7WqeXcL97LOlJi0pp4b5nk/K8R1oXA8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdYi8OKiyAL9QH1zraVdQ6baOjUcx3W+Ar5JIB0FFiapV3k/v8v3WVGZ6RA6W+TDLjdhsR7JFAGB0kSQMVaplsgQJN0nhLc5H2zBpGIKMOImMsNiCmul/RWL3ZIZusQMjJH5arh+ItCPWggYlY22y7rYXu8IIO4PkUO4bJAQ7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzTrdYeF; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63606491e66so1763025d50.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760111103; x=1760715903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jsHYs4uIkHkI1sffpJWkCivG9hy9oHIHIWqTKpL433E=;
        b=OzTrdYeFClcNxGzDxOV9teIQ0LcwAxKm6Z+Sm97H4KmkwhAWCgumctL1tYDS9GSlmQ
         T1t5oRQUgaOyLx8jAystV0GjRQlMg6wkHu2RFsedR4+anGhJ9+qY2e1zh++lQxM9hKcD
         XZKMR0eZ4D5mQyJqjL0siBZxM/QhmblsZ9D5cB9stNya/kKloHBkFNwRw+VbSu1OAF59
         I+bugSx5y55GrwPEaMpuVyhf7cRmUzT3CSAfgBaxu+J06uhf5ZrxxmIqYGiliL0KFhL9
         NNCWWv9Qc4FMRMwQEqdQh5bC3M31f5zF7Ex/Xj0rtLl7PwTt2xBiBjMMWPD4YJCjimQt
         Y7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111103; x=1760715903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsHYs4uIkHkI1sffpJWkCivG9hy9oHIHIWqTKpL433E=;
        b=u9W7mGROtB0bh5nWE2+YftZlx6LTTq5W9aJ6WLbZx18GyPTnYFiHe2Vh8dS/krtAZW
         lBNbjYnqbyDa6u+wqL5KtNaFyMXmAx6pqa5Li50n0piCxDbN4CxSLAXC4++Nz/+Cvb4m
         mrqDn9RL0YfHHxk0KE/wbABneiq16wiMr34TQiINFyQ92k39o05ydmyuQWfFrIz0egGX
         j5RgulomZXn0DJD9Bmw7RaBIE44Eu2y7+oYNangtKH7VdiNQySIWjR+ibr7rAhncDc5T
         FrzTRsZ0tIpEN3sixrUC8QZCHUR/ia901DNadV+qZAYsFyNdGiKoa5uH3WJ/5B/GVB4v
         J8uA==
X-Forwarded-Encrypted: i=1; AJvYcCWnGmnMrgNJ52Pza6zL2XNvfnJjlUqgRv4a6XQMrSHx18uhNi4Z3aC+jowFe2O6PKET3KQOAQA0vCaBY66O@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Qs+cBXCbuJ0sA0I2QCS1CcxpuOiyPPTzwJayR/wzchyj4EEP
	OyYNQ0twCVJOPHajlMyOy9vsim+jQKi0WW6BcJE3c/J+a0o0QuNF+5Go1aHGcjZfP61uiv/9MgR
	lKFhK0r5hH44Rvyl+xNio8PLk99PIDLuJHcmS
X-Gm-Gg: ASbGncutifPgRYPUA3PT3hCKqoo/HrRl84LpUgHFFjFXqfAqL3pApltfYaMKwxucI01
	i4MFGYUOKTPKokduI6bJi6+rPdCHse9EZtmxOLyaT2Pnh8qp/sGCRggrabPqmNd1NEtqTDKCN6U
	GseahFbPANwrTd7O0DCYP3v1QbUDsWYmwsAWNvOxnQe80srA3l2yd0oNlhlMPlZWmfXM4tekZFr
	2JH/03JlfHMx+12YkUfLNAK
X-Google-Smtp-Source: AGHT+IGxCxtXnllK78fJlfJY/bSfY4HfkDNUqCjCz/Ww5zmauzu8GFnXbB6t5M8TRaeAiefmOPiNjrSlXzvK+6pC04Y=
X-Received: by 2002:a53:ba85:0:b0:633:a326:3b07 with SMTP id
 956f58d0204a3-63ccb8d82cfmr7959488d50.24.1760111102603; Fri, 10 Oct 2025
 08:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp>
In-Reply-To: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Fri, 10 Oct 2025 16:44:51 +0100
X-Gm-Features: AS18NWAlQZpTS30VoVGatJslkKbpukKpiNdX9vYjqF3r78Zk02CmXQdCM21jgaY
Message-ID: <CAK+_RL=ybNZz3z-Fqxhxg+0fnuA1iRd=MbTCZ=M3KbSjFzEnVg@mail.gmail.com>
Subject: Re: [PATCH] bfs: Verify inode mode when loading from disk
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 15:24, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> The inode mode loaded from corrupted disk can be invalid.
> Since Boot File System supports only root directory and regular files [1],
> reject inodes which are neither directory nor regular file.
>
> ...
> +       if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode)) {
> +               brelse(bh);
> +               printf("Bad file type (0%04o) %s:%08lx.\n",
> +                      inode->i_mode, inode->i_sb->s_id, ino);
> +               goto error;
> +       }

Thank you, but logically this code should simply be inside the "else"
clause of the previous checks, which already check for BFS_VDIR and
BFS_VREG, I think.

--
Tigran

